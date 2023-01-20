
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/db/entities/helper/int_data.dart';
import 'package:hadith/db/services/audio_edition_dao.dart';
import 'package:hadith/db/remote/dto/edition_dto.dart';
import 'package:hadith/features/verse/verse_download_audio/services/quran_download_service.dart';
import 'package:hadith/models/resource.dart';
import 'package:hadith/services/connectivity_service.dart';

class AudioEditionRepo{
  final AudioEditionDao editionDao;
  final QuranDownloadService downloadService;

  AudioEditionRepo({required this.editionDao,required this.downloadService});

  Stream<List<AudioEdition>> getStreamEditions() => editionDao.getStreamEditions();

  Future<IntData?>isEditionNotEmpty() => editionDao.isEditionNotEmpty();

  Future<AudioEdition?> getSelectedEdition() => editionDao.getSelectedEdition();

  Stream<AudioEdition?>getSelectedStreamEdition() => editionDao.getSelectedStreamEdition();

  Future<Resource<AudioEdition?>>getSelectedEditionResource()async{
    final selectedEdition = await editionDao.getSelectedEdition();
    if(selectedEdition!=null){
      return ResourceSuccess(selectedEdition);
    }
    final isEditionsEmpty = (await editionDao.isEditionNotEmpty())?.data == 0;

    if(isEditionsEmpty){
      if(!await ConnectivityService.isConnectedInternet()){
        return Resource.error("internet bağlantınızı kontrol edin");
      }
      final data = await _downloadAudioEditions();
      if(data is ResourceSuccess<void>){
        return Resource.success(await editionDao.getSelectedEdition());
      }else{
        return Resource.error("bir şeyler yanlış gitti");
      }
    }else{
      final editions = await editionDao.getEditions();
      final selectedEdition = _getSelectedEditionFromList(editions);
      final selectedEditions = _setSelectedEdition(editions, selectedEdition.identifier);
      await editionDao.updateAudioEditions(selectedEditions);
      return Resource.success(selectedEdition);
    }
  }

  Future<Resource<List<AudioEdition>>>refreshEditions(bool forceRemote)async{

    if(!await ConnectivityService.isConnectedInternet()){
      return Resource.error("internet bağlantınızı kontrol edin");
    }
    Resource<void>? downloadResponse;

    if(forceRemote){
      downloadResponse = await _downloadAudioEditions();
    }else{
      final isEditionsEmpty = (await editionDao.isEditionNotEmpty())?.data == 0;
      if(!isEditionsEmpty){
        return Resource.success(await editionDao.getEditions());
      }
      downloadResponse = await _downloadAudioEditions();
    }
    if(downloadResponse is ResourceError<List<void>>){
      return Resource.error(downloadResponse.error);
    }
    return Resource.success(await editionDao.getEditions());
  }

  AudioEdition _getSelectedEditionFromList(List<AudioEdition>editions){
    final AudioEdition? alafasyEdition = editions.firstWhere((element) => element.identifier == "ar.alafasy");
    return alafasyEdition??editions.first;
  }

  Future<Resource<void>>_downloadAudioEditions()async{
    if(!await ConnectivityService.isConnectedInternet()){
      return Resource.error("internet bağlantınızı kontrol edin");
    }
    final response = await downloadService.getEditions();
    if(response is ResourceSuccess<List<EditionDto>>){
      final audioEditions = response.data.map((e) => e.toAudioEdition()).toList();
      if(audioEditions.isEmpty){
        return Resource.error("bir şeyler yanlış gitti");
      }
      final selectedEdition = _getSelectedEditionFromList(audioEditions);
      final selectedEditions = _setSelectedEdition(audioEditions, selectedEdition.identifier);
      await editionDao.insertEditions(selectedEditions);
      return Resource.success(null);
    }
    return Resource.error("bir şeyler yanlış gitti");
  }

  List<AudioEdition>_setSelectedEdition(List<AudioEdition>editions,String identifier){
    return editions.map((e) => e.copyWith(isSelected: e.identifier == identifier)).toList();
  }

  Future<List<int>> insertEditions(List<AudioEdition>items)=>editionDao.insertEditions(items);

  Future<List<AudioEdition>> getEditions() => editionDao.getEditions();

  Future<int>updateAudioEditions(List<AudioEdition>editions) => editionDao.updateAudioEditions(editions);
}