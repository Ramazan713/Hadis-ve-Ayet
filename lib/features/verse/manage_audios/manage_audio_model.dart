

import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/cuz.dart';
import 'package:hadith/db/entities/views/cuz_audio_view.dart';
import 'package:hadith/db/entities/views/surah_audio_view.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';

class ManageAudioModel extends Equatable{

  final String editionName;
  final String identifier;
  final int key;
  final bool isDownloaded;
  final String keyName;
  final AudioManageEnum manageEnum;


  const ManageAudioModel({required this.editionName, required this.identifier, required this.key,
    required this.isDownloaded, required this.manageEnum,required this.keyName});


  static ManageAudioModel fromCuzAudioView(CuzAudioView cuzView,String cuzName){
    return ManageAudioModel(editionName: cuzView.editionName, identifier: cuzView.identifier,
        key: cuzView.cuzNo, isDownloaded: cuzView.isDownloaded, manageEnum: AudioManageEnum.cuz, keyName: cuzName);
  }

  static ManageAudioModel fromSurahAudioView(SurahAudioView surahView,String surahName){
    return ManageAudioModel(editionName: surahView.editionName, identifier: surahView.identifier,
        key: surahView.surahId, isDownloaded: surahView.isDownloaded, manageEnum: AudioManageEnum.surah, keyName: surahName);
  }

  CuzAudioView toCuzAudioView(){
    return CuzAudioView(identifier: identifier,cuzNo: key,editionName: editionName,isDownloaded: isDownloaded);
  }

  SurahAudioView toSurahAudioView(){
    return SurahAudioView(editionName: editionName, identifier: identifier, isDownloaded: isDownloaded, surahId: key);
  }

  @override
  List<Object?> get props => [editionName,key,isDownloaded,manageEnum,identifier];

}