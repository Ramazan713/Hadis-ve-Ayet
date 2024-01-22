

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/presentation/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/presentation/bloc/topic_save_point_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/core/presentation/selections/show_bottom_menu_items.dart';
import 'package:hadith/features/verses/shared/domain/models/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_topic_model.dart';
import 'package:hadith/core/features/verse_audio/domain/model/audio_param_builder.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/enums/verse_topic_bottom_menu_item.dart';

void verseTopicBottomMenuSharedHandler(BuildContext context,
{
  required bool hasSavePoint,
  required int index,
  required VerseTopicModel topicModel,
  required int itemId,
  required AudioInfoResultModel<int> audioResult,
  required void Function() onGoToLastSavePoint,
  required QuranAudioOption audioOption
}){
  final topicSavePointBloc = context.read<TopicSavePointBloc>();
  final downloadedView = topicModel.audioViewModel;

  final listenAudioBloc = context.read<ListenVerseAudioBloc>();
  final downloadAudioBloc = context.read<DownloadAudioBloc>();


  final audioBuilder = AudioParamBuilder(
      itemId: itemId,
      checkNotification: true,
      op: audioOption
  );

  showBottomMenuItems(
      context,
      items: VerseTopicBottomMenuItem.getMenuItems(
          topicModel: topicModel,
          hasSavePoint: hasSavePoint,
          audioInfo: audioResult,
          itemId: itemId
      ),
      onItemClick: (menuItem){
        context.pop();
        switch(menuItem){
          case VerseTopicBottomMenuItem.startListenAudios:
            listenAudioBloc.add(ListenAudioEventStartListeningWithParam(
                paramBuilder: audioBuilder
            ));
            break;
          case VerseTopicBottomMenuItem.stopListenAudios:
            listenAudioBloc.add(ListenAudioEventStop());
            break;
          case VerseTopicBottomMenuItem.startDownloadAudios:
            downloadAudioBloc.add(DownloadAudioEventStartDownloadingWithBuilder(
                paramBuilder: audioBuilder
            ));
            break;
          case VerseTopicBottomMenuItem.deleteAudios:
            if(downloadedView!=null){
              showCustomAlertDia(context,
                  title: "Silmek istediğinize emin misiniz?",
                  content: "Silinen ses dosyaları geri alınamaz",
                  btnApproved: (){
                    context.read<ManageAudioBloc>()
                        .add(ManageAudioEventDelete(downloadedView));
                  }
              );
            }
            break;
          case VerseTopicBottomMenuItem.goToLastSavePoint:
            onGoToLastSavePoint();
            break;
          case VerseTopicBottomMenuItem.signSavePoint:
            topicSavePointBloc.add(TopicSavePointEventInsertSavePoint(pos: index));
            break;
          case VerseTopicBottomMenuItem.unSignSavePoint:
            topicSavePointBloc.add(TopicSavePointEventDeleteSavePoint());
            break;
        }
      }
  );
}