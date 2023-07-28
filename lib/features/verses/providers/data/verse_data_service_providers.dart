

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/verses/shared/data/services/quran_download_service_impl.dart';
import 'package:hadith/features/verses/shared/data/services/verse_audio_just_service.dart';
import 'package:hadith/features/verses/shared/domain/services/audio_file_editor.dart';
import 'package:hadith/features/verses/shared/domain/services/i_verse_audio_service.dart';
import 'package:hadith/features/verses/shared/domain/services/quran_download_service.dart';

import '../../shared/data/services/audio_file_editor_impl.dart';

List<RepositoryProvider> pVerseDataServiceProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<AudioFileEditor>(create: (context) => AudioFileEditorImpl()),
    RepositoryProvider<QuranDownloadService>(create: (context) => QuranDownloadServiceImpl()),
  ];
}