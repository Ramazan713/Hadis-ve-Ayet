
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/features/verse_audio/domain/model/download_verse/download_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/model/listen_audio/listen_audio_param.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';
import 'package:hadith/core/features/verse_audio/domain/model/select_audio_option.dart';

class AudioParamBuilder extends Equatable{
  final String? identifier;
  final QuranAudioOption? op;
  final int? itemId;
  final int? startVerseId;
  final Verse? verse;
  final bool checkNotification;
  final SelectAudioOption selectAudioOption;

  const AudioParamBuilder({
    this.itemId,
    this.op,
    this.identifier,
    this.startVerseId,
    this.verse,
    this.checkNotification = true,
    this.selectAudioOption = SelectAudioOption.cuz
  });

  AudioParamBuilder copyWith({
    String? identifier, bool setIdentifier = false,
    QuranAudioOption? op, bool setOption = false,
    int? itemId, bool setItemId = false,
    int? startVerseId, bool setStartVerseId = false,
    bool? checkNotification,
    Verse? verse, bool setVerse = false,
    SelectAudioOption? selectAudioOption
  }){
    return AudioParamBuilder(
      op: setOption ? op : this.op,
      startVerseId: setStartVerseId ? startVerseId : this.startVerseId,
      identifier:  setIdentifier ? identifier : this.identifier,
      itemId: setItemId ? itemId : this.itemId,
      checkNotification: checkNotification ?? this.checkNotification,
      verse: setVerse ? verse : this.verse,
      selectAudioOption: selectAudioOption ?? this.selectAudioOption
    );
  }

  bool get hasIdentifier => identifier != null;
  bool get hasOption => op != null;
  bool get hasItemId => itemId != null;

  ListenAudioParam? toListenAudioParam(){
    final pIdentifier = identifier;
    final pItemId = _getItemId();
    final pOp = op;
    if(pIdentifier == null || pItemId == null || pOp == null){
      return null;
    }
    return ListenAudioParam(
        identifier: pIdentifier,
        itemId: pItemId,
        op: pOp,
        startVerseId: startVerseId
    );
  }

  DownloadAudioParam? toDownloadAudioParam({required AudioQualityEnum audioQualityEnum}){
    final pIdentifier = identifier;
    final pItemId = _getItemId();
    final pOp = op;
    if(pIdentifier == null || pItemId == null || pOp == null){
      return null;
    }
    return DownloadAudioParam(
        identifier: pIdentifier,
        itemIdForOption: pItemId,
        op: pOp,
        audioQualityEnum: audioQualityEnum,
        startVerseId: startVerseId
    );
  }

  int? _getItemId(){
    if(itemId != null) return itemId;
    final pVerse = verse;
    final pOp = op;
    if(pVerse != null && pOp != null){
      switch(pOp){
        case QuranAudioOption.cuz:
          return pVerse.cuzNo;
        case QuranAudioOption.surah:
          return pVerse.surahId;
        case QuranAudioOption.page:
          return pVerse.pageNo;
        case QuranAudioOption.verse:
          return pVerse.id;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [identifier,op,itemId,startVerseId,checkNotification,
    verse, selectAudioOption
  ];
}