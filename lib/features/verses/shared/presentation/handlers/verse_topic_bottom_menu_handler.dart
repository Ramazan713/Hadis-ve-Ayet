

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_bloc.dart';
import 'package:hadith/core/features/save_point/load_save_point/bloc/load_save_point_event.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_bloc.dart';
import 'package:hadith/core/features/topic_save_point/bloc/topic_save_point_event.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_bottom_menu_items.dart';
import 'package:hadith/features/save_point/constants/save_auto_type.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/enums/verse_topic_bottom_menu_item.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_info_result_model.dart';
import 'package:hadith/features/verses/shared/domain/model/verse_topic_model.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/download_verse_audio/bloc/download_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verses/shared/presentation/features/listen_verse_audio/bloc/verse_audio_event.dart';
import 'package:hadith/features/verses/shared/presentation/models/audio_param_builder.dart';

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
              showCustomAlertBottomDia(context,
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