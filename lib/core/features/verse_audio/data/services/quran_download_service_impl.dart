

import 'dart:async';
import 'dart:typed_data';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/verse_downloaded_model.dart';
import 'package:hadith/core/features/verse_audio/domain/services/quran_download_service.dart';
import 'package:hadith/core/utils/stream_resource.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class QuranDownloadServiceImpl extends QuranDownloadService{

  Client? _singleDownloadClient;

  @override
  Future<Resource<Uint8List>> downloadSingleAudio({
    required String identifier,
    required int verseId,
    AudioQualityEnum audioQuality = AudioQualityEnum.q64
  }) async{
    final headerPath = _getHeaderAudio(identifier, verseId);
    final url = "https://cdn.islamic.network/quran/audio/${audioQuality.quality}/$headerPath";

    try{
      _singleDownloadClient?.close();
      _singleDownloadClient = Client();
      final response = await _singleDownloadClient!.get(Uri.parse(url));

      if(response.statusCode==200){
        return Resource.success(response.bodyBytes);
      }else{
        return Resource.error("error");
      }
    }catch(e){
      return Resource.error(e.toString());
    }

  }

  final BehaviorSubject<StreamResource<VerseDownloadedVoiceModel>> _progressController = BehaviorSubject();

  @override
  ValueStream<StreamResource<VerseDownloadedVoiceModel>>? get streamDownloadListener  =>
      _progressController.stream.shareValue();

  StreamSubscription<StreamResource<VerseDownloadedVoiceModel>>? _innerDownloadListener;
  StreamSubscription<List<int>>? _dataListener;


  int _downloadProgress = 0, _totalCount = 0;
  Client? _client;




  @override
  Future<void> initStream(int itemCount)async{
    await _cancelListeners();
    _totalCount = itemCount;
    _downloadProgress = 0;
    _client = http.Client();
  }

  Future<void>_downloadStreamVoice(
      String identifier,
      VerseDownloadedVoiceModel model,
      List<int> bytes,
      AudioQualityEnum audioQuality
  )async{

    if(_client!=null) {
      try{
        _progressController.add(StreamResource.loadingWithData(progress: _downloadProgress, total: _totalCount, data: model));

        final headerPath = _getHeaderAudio(identifier, model.verseId);
        final url = "https://cdn.islamic.network/quran/audio/${audioQuality.quality}/$headerPath";

        final response=await _client!.send(http.Request("GET",Uri.parse(url)));

        if(response.statusCode!=200){
          _progressController.add(StreamResource.error("bir şeyler yanlış gitti. Kıraatı değiştirmeyi deneyin"));
          return;
        }
        await _dataListener?.cancel();
        _dataListener = response.stream.listen((value) {
          bytes.addAll(value);
        });
        _dataListener?.onDone(() async{
          _progressController.add(StreamResource.successStep(model));
        });
        _dataListener?.onError((e)async{
          _progressController.add(StreamResource.error(e.toString()));
        });
      }catch(e){
        _progressController.add(StreamResourceError("something went wrong"));
      }
    }
  }

  @override
  Future<void> startStreamDownloading({
    required String identifier,
    required List<VerseDownloadedVoiceModel> models,
    required AudioQualityEnum audioQuality
  })async{
    await _innerDownloadListener?.cancel();

    final List<int> bytes = [];
    int index = 0;
    int size = models.length;

    var model = models[index];
    await _downloadStreamVoice(identifier, model, bytes,audioQuality);

    _innerDownloadListener = streamDownloadListener?.listen((event) async{

      if(event is StreamResourceSuccessStep<VerseDownloadedVoiceModel>){
        _downloadProgress++;
        index++;
        if(index < size){
          model = models[index];
          await _downloadStreamVoice(identifier, model, bytes,audioQuality);
        }else{
          _progressController.add(StreamResourceSuccessAll(bytes));
        }
      }
    });

  }


  @override
  void pause(){
    _dataListener?.pause();
    _innerDownloadListener?.pause();
  }

  @override
  void resume(){
    _dataListener?.resume();
    _innerDownloadListener?.resume();
  }


  @override
  Future<void> cancel()async{
    _singleDownloadClient?.close();
    _singleDownloadClient = null;
    await _cancelListeners();
    _client?.close();
  }

  Future<void> _cancelListeners()async{
    await _innerDownloadListener?.cancel();
    await _dataListener?.cancel();
  }

  String _getHeaderAudio(String identifier, int verseId){
    return "$identifier/$verseId.mp3";
  }

  @override
  Future<void> dispose() async{
    await cancel();
    await _progressController.close();
  }

}