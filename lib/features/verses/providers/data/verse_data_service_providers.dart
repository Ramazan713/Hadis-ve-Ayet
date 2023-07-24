

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/verses/shared/domain/services/audio_file_editor.dart';

import '../../shared/data/services/audio_file_editor_impl.dart';

List<RepositoryProvider> pVerseDataServiceProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<AudioFileEditor>(create: (context) => AudioFileEditorImpl()),
  ];
}