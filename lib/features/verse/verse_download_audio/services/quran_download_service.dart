

import 'dart:async';
import 'dart:convert';

import 'package:hadith/db/entities/verse_audio.dart';
import 'package:hadith/db/repos/verse_audio_repo.dart';
import 'package:hadith/db/remote/dto/edition_dto.dart';
import 'package:hadith/features/verse/common_constants/audio_quality_enum.dart';
import 'package:hadith/features/verse/common_services/file_service.dart';
import 'package:hadith/db/entities/helper/download_voice_entity.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/models/stream_resource.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class QuranDownloadService{
  final FileService _writerService = FileService();
  late final VerseAudioRepo _audioRepo;

  QuranDownloadService({required VerseAudioRepo audioRepo}){
    _audioRepo = audioRepo;
  }

  Future<Resource<List<EditionDto>>> getEditions()async{
    const url="https://api.alquran.cloud/v1/edition?format=audio&language=ar&type=versebyverse";
    try{
      final response = await http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
      });
      if(response.statusCode==200){
        final data = EditionDto.fromJsonArr(jsonDecode(response.body)["data"]);
        return Resource.success(data);
      }else{
        return Resource.error("error");
      }
    }catch(e){
      return Resource.error(e.toString());
    }
  }


  Future<Resource<bool>>downloadSingleVoice(String identifier,int verseId,int mealId,{AudioQualityEnum audioQuality = AudioQualityEnum.q64})async{
    final headerPath = VerseAudio.headerFileName(identifier, verseId);
    final url = "https://cdn.islamic.network/quran/audio/${audioQuality.quality}/$headerPath";
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        final newFileName = VerseAudio.newFileName(identifier, mealId);
        final arabicAudio = VerseAudio(mealId: mealId, identifier: identifier, fileName: newFileName,hasEdited: true);
        await _audioRepo.insertVerseAudio(arabicAudio);
        await _writerService.writeFile(response.bodyBytes, newFileName);
        return Resource.success(true);
      }else{
        return Resource.error("error");
      }
    }catch(e){
      return Resource.error(e.toString());
    }
  }

  StreamController<StreamResource<DownloadVoiceEntity>>? _progressController;
  Stream<StreamResource<DownloadVoiceEntity>>? broadcastStream;
  StreamSubscription<StreamResource<DownloadVoiceEntity>>? _broadcastListener;
  StreamSubscription<List<int>>? _dataListener;


  int _downloaded = 0, _totalCount = 0;
  Client? _client;


  void onPause(){
    _dataListener?.pause();
    _broadcastListener?.pause();
  }

  void onResume(){
    _dataListener?.resume();
    _broadcastListener?.resume();
  }

  Future<void> _cancelListeners()async{
    await _broadcastListener?.cancel();
    await _dataListener?.cancel();
  }

  Future<void> onCancel()async{
    await _cancelListeners();
    await _progressController?.close();
    _client?.close();
  }

  void initForStreamDownloading(int itemCount)async{
    _progressController = StreamController();
    broadcastStream = _progressController?.stream.asBroadcastStream();
    _totalCount = itemCount;
    _downloaded = 0;
    _client = http.Client();
    await _cancelListeners();
  }

  Future<void>_downloadStreamVoice(String identifier,DownloadVoiceEntity model,List<int> _bytes,AudioQualityEnum audioQuality)async{
    if(_client!=null) {
      try{
        _progressController?.add(StreamResource.loadingWithData(downloaded: _downloaded, total: _totalCount, data: model));

        final headerPath = VerseAudio.headerFileName(identifier, model.verseId);
        final url = "https://cdn.islamic.network/quran/audio/${audioQuality.quality}/$headerPath";

        final response=await _client!.send(http.Request("GET",Uri.parse(url)));

        if(response.statusCode!=200){
          _progressController?.add(StreamResource.error("bir şeyler yanlış gitti. Kıraatı değiştirmeyi deneyin"));
          _client?.close();
          return;
        }
        _dataListener = response.stream.listen((value) {
          _bytes.addAll(value);
        });
        _dataListener?.onDone(() async{
          _progressController?.add(StreamResource.successItem(model));
        });
        _dataListener?.onError((e)async{
          _progressController?.add(StreamResource.error(e.toString()));
          _client?.close();
        });
      }catch(e){
        _progressController?.add(StreamResourceError("something went wrong"));
      }
    }
  }

  Future<void> startStreamDownloading(String identifier,List<DownloadVoiceEntity> models,{required AudioQualityEnum audioQuality})async{
    await _broadcastListener?.cancel();

    final List<int> _bytes = [];
    int index=0;
    int size = models.length;

    var model = models[index];
    await _downloadStreamVoice(identifier, model, _bytes,audioQuality);

    _broadcastListener=broadcastStream?.listen((event) async{

      if(event is StreamResourceSuccessItem<DownloadVoiceEntity>){
        _downloaded++;
        index++;
        if(index<size){
          model = models[index];
          await _downloadStreamVoice(identifier, model, _bytes,audioQuality);
        }else{
          final newFileName = VerseAudio.newFileName(identifier, event.data.mealId);
          final arabicAudio = VerseAudio(mealId: model.mealId, identifier: identifier, fileName: newFileName,
              hasEdited: models.length==1);
          await _audioRepo.insertVerseAudio(arabicAudio);
          await _writerService.writeFile(_bytes, newFileName);
          _progressController?.add(StreamResource.successFinished());
        }
      }
    });

  }
}