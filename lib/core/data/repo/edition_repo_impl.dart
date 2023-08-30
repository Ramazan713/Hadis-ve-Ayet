import 'package:hadith/core/data/local/services/audio_edition_dao.dart';
import 'package:hadith/core/data/remote/dto/edition_dto.dart';
import 'package:hadith/core/extensions/app_extension.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';
import 'package:hadith/core/data/mapper/edition_mapper.dart';
import 'package:hadith/core/data/remote/edition_download_service.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/domain/repo/edition_repo.dart';
import 'package:hadith/core/utils/resource.dart';


class EditionRepoImply extends EditionRepo{

  late final AudioEditionDao _editionDao;
  late final EditionDownloadService _downloadService;
  late final ConnectivityService _connectivityService;

  EditionRepoImply({
    required AudioEditionDao editionDao,
    required EditionDownloadService downloadService,
    required ConnectivityService connectivityService
  }){
    _editionDao = editionDao;
    _downloadService = downloadService;
    _connectivityService = connectivityService;
  }

  @override
  Future<Resource<List<AudioEdition>>> getEditions() async{
    var editions = await _editionDao.getEditions();
    if(editions.isEmpty){
      final response = await _downloadAndSaveEditions();
      if(response is ResourceError<void>) {
        return ResourceError(response.error);
      }
      editions = await _editionDao.getEditions();
    }

    return ResourceSuccess(editions.map((e) => e.toEdition()).toList());
  }

  @override
  Future<Resource<AudioEdition?>> getSelectedEdition() async{
    var selectedEdition = await _editionDao.getSelectedEdition();

    if(selectedEdition == null){
      final response = await _downloadAndSaveEditions();
      if(response is ResourceError<void>) {
        return ResourceError(response.error);
      }
      selectedEdition = await _editionDao.getSelectedEdition();
    }
    return ResourceSuccess(selectedEdition?.toEdition());
  }

  @override
  Stream<AudioEdition?> getSelectedStreamEdition() {
    return _editionDao.getSelectedStreamEdition().map((e) => e?.toEdition());
  }

  @override
  Stream<List<AudioEdition>> getStreamEditions() {
    return _editionDao.getStreamEditions()
        .map((items) => items.map((e) => e.toEdition()).toList());
  }


  Future<Resource<void>> _downloadAndSaveEditions()async{

    //check connectivity
    if(!await _connectivityService.hasConnected){
      return ResourceError("internet bağlantınızı kontrol edin");
    }

    //download editions
    final response = await _downloadService.getEditions();
    if(response is ResourceError<List<EditionDto>>){
      return ResourceError(response.error);
    }

    final editionsDto = response.castOrNull<ResourceSuccess<List<EditionDto>>>()?.data;

    if(editionsDto == null || editionsDto.isEmpty){
      return ResourceError("bilinmeyen bir hata oluştu");
    }


    final editionEntities = editionsDto.map((e) => e.toEditionEntity()).toList();

    //set default edition
    int selectedEditionIndex = editionEntities.indexWhere((e) => e.identifier == "ar.alafasy");
    if(selectedEditionIndex==-1){
      selectedEditionIndex = 0;
    }
    final selectedEdition = editionEntities[selectedEditionIndex].copyWith(isSelected: true);
    editionEntities[selectedEditionIndex] = selectedEdition;

    //insert editions
    await _editionDao.insertEditions(editionEntities);

    return ResourceSuccess(null);
  }

  @override
  Future<void> setSelectedEdition(String identifier) async{
    var editions = await _editionDao.getEditions();
    if(editions.isEmpty) return;

    final index = editions.indexWhere((element) => element.identifier == identifier);
    if(index == -1) return;

    editions = editions.map((e) => e.copyWith(isSelected: false)).toList();
    final selectedEdition = editions[index].copyWith(isSelected: true);
    editions[index] = selectedEdition;

    await _editionDao.updateAudioEditions(editions);
  }


}