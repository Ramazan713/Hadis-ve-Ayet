

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/selections/custom_choice_chips.dart';
import 'package:hadith/core/presentation/components/selections/dropdown_text_menu.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_state.dart';
import 'package:hadith/core/features/manage_downloaded_audio/components/downloaded_audio_view_item.dart';

void showManageDownloadedAudios(BuildContext context,{bool useRootNavigator = true}){



  void onNavigateBack(){
    Navigator.of(context,rootNavigator: useRootNavigator).pop();
  }

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: useRootNavigator,
      useSafeArea: true,
      builder: (context){
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 1,
          builder: (context,draggableScrollController){
            return _DialogContent(
              controller: draggableScrollController,
              onNavigateBack: onNavigateBack,
            );
          },
        );
      }
  );
}


class _DialogContent extends StatelessWidget {

  final void Function() onNavigateBack;
  final ScrollController controller;

  const _DialogContent({
    Key? key,
    required this.controller,
    required this.onNavigateBack
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final manageBloc = context.read<ManageAudioBloc>();
    manageBloc.add(ManageAudioEventLoadData(identifier: null));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 11),
      child: Column(
        children: [
          getHeader(context),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: getFilterMenu()
                    ),
                  ),
                  getContent()
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  Widget getContent(){
    return BlocBuilder<ManageAudioBloc,ManageAudioState>(
        buildWhen: (prevState, nextState){
          return prevState.models != nextState.models;
        },
        builder: (context,state){
          final models = state.models;

          if(models.isEmpty){
            return const SharedEmptyResult(
              content: "İndirilmiş herhangi bir ses dosyası bulunamadı",
            );
          }

          return ListView.builder(
            controller: ScrollController(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              final item = models[index];
              return DownloadedAudioViewItem(
                model: item,
                showEditionName: true,
                onDeletePressed: (){
                  showCustomAlertDia(
                      context,
                      title: "Silmek istediğinize emin misiniz?",
                      content: "Bu işlem geri alınamaz",
                      btnApproved: (){
                        context.read<ManageAudioBloc>()
                            .add(ManageAudioEventDelete(item));
                      }
                  );
                },
              );
            },
            itemCount: models.length,
          );
        });
  }

  Widget getFilterMenu(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: BlocSelector<ManageAudioBloc,ManageAudioState,DownloadedAudioViewEnum>(
        selector: (state)=> state.selectedEnum ?? DownloadedAudioViewEnum.surah,
        builder: (context,currentEnum){
          return CustomChoiceChips(
            items: DownloadedAudioViewEnum.values,
            selectedItem: currentEnum,
            onSelected: (selected){
              context.read<ManageAudioBloc>()
                  .add(ManageAudioEventChangeAudioViewType(selected));
            },
          );
        }
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            "indirilen ses dosyalarının yönetimi",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onNavigateBack,
            icon: const Icon(Icons.close),
          ),
        )
      ],
    );
  }
}

