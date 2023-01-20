

import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/entities/verse_audio.dart';
import 'package:hadith/db/services/verse_audio_dao.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verse/common_services/file_audio_editor.dart';

class VerseAudioEditorRepo{
  late final VerseAudioDao _audioDao;
  late final FileAudioEditor _fileAudioEditor;

  VerseAudioEditorRepo({required VerseAudioDao audioDao,required FileAudioEditor fileAudioEditor}){
    _audioDao = audioDao;
    _fileAudioEditor = fileAudioEditor;
  }

  Future<void>editUnEditedAudios(String identifier,Verse verse,QuranAudioOption option)async{
    final audioVerses = option == QuranAudioOption.cuz ? await _audioDao.getUnEditedVerseAudiosWithCuzNo(verse.cuzNo, identifier) :
        await _audioDao.getUnEditedVerseAudiosWithSurahId(verse.surahId, identifier);

    final appDocDir = await VerseAudio.appDocDirPath();
    final files = audioVerses.map((e) => VerseAudio.getAudioFileWithDir(appDocDir, e.fileName??"")).toList();
    await _fileAudioEditor.reWriteFiles(files);
    await _audioDao.updateVerseAudios(audioVerses.map((e) => e.copyWith(hasEdited: true)).toList());
  }
}