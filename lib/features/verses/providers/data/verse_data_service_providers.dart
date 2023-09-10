

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/data/services/audio_file_editor_impl.dart';
import 'package:hadith/core/features/verse_audio/data/services/quran_download_service_impl.dart';
import 'package:hadith/core/features/verse_audio/domain/services/audio_file_editor.dart';
import 'package:hadith/core/features/verse_audio/domain/services/quran_download_service.dart';
import 'package:hadith/db/database.dart';

List<RepositoryProvider> pVerseDataServiceProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<AudioFileEditor>(create: (context) => AudioFileEditorImpl()),
    RepositoryProvider<QuranDownloadService>(create: (context) => QuranDownloadServiceImpl()),
  ];
}