
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/data/manager/verse_audio_download_manager_impl.dart';
import 'package:hadith/core/features/verse_audio/data/services/verse_audio_just_service.dart';
import 'package:hadith/core/features/verse_audio/domain/manager/verse_audio_download_manager.dart';
import 'package:hadith/core/features/verse_audio/domain/services/i_verse_audio_service.dart';
import 'package:hadith/db/database.dart';

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