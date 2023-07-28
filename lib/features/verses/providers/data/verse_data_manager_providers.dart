
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/database.dart';
import 'package:hadith/features/verses/shared/data/manager/verse_audio_download_manager_impl.dart';
import 'package:hadith/features/verses/shared/data/services/verse_audio_just_service.dart';
import 'package:hadith/features/verses/shared/domain/manager/verse_audio_download_manager.dart';
import 'package:hadith/features/verses/shared/domain/services/i_verse_audio_service.dart';



List<RepositoryProvider> pVerseDataManagerProviders(BuildContext context,AppDatabase appDatabase){
  return [
    RepositoryProvider<IVerseAudioServiceManager>(create: (context) => VerseAudioJustService(
      appPreferences: context.read(),
      fileService: context.read(),
      verseAudioRepo: context.read(),
      verseVoiceRepo: context.read(),
    )),

    RepositoryProvider<VerseAudioDownloadManager>(create: (context)=>VerseAudioDownloadManagerImpl(
        quranDownloadService: context.read(),
        verseAudioRepo: context.read(),
        connectivityService: context.read(),
        verseDownloadedVoiceRepo: context.read()
    ))
  ];
}