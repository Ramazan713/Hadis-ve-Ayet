

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/dropdown_text_menu.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_state.dart';
import 'package:hadith/core/features/manage_downloaded_audio/components/downloaded_audio_view_item.dart';

void showManageEditionAudios(BuildContext context, {
  required AudioEdition audioEdition,
  bool useRootNavigator = true
}){

  void onNavigateBack(){
    Navigator.of(context,rootNavigator: useRootNavigator).pop();
  }

  showModalBottomSheet(
      context: context,
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context){
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.5,
          initialChildSize: 0.6,
          maxChildSize: 1,
          builder: (context,draggableScrollController){
            return _DialogContent(
              audioEdition: audioEdition,
              onNavigateBack: onNavigateBack,
              controller: draggableScrollController,
            );
          },
        );
      });

}

class _DialogContent extends StatelessWidget {

  final AudioEdition audioEdition;
  final ScrollController controller;
  final void Function() onNavigateBack;

  const _DialogContent({
    Key? key,
    required this.audioEdition,
    required this.controller,
    required this.onNavigateBack
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final manageBloc = context.read<ManageAudioBloc>();
    manageBloc.add(ManageAudioEventLoadData(identifier: audioEdition.identifier));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getHeader(context),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: getDropdownMenu()
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
            shrinkWrap: true,
            controller: ScrollController(),
            itemBuilder: (context,index){
              final item = models[index];
              return DownloadedAudioViewItem(
                model: item,
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
        }
    );
  }

  Widget getDropdownMenu(){
    return BlocSelector<ManageAudioBloc,ManageAudioState,DownloadedAudioViewEnum?>(
        selector: (state)=>state.selectedEnum,
        builder: (context,currentEnum){
          return CustomDropdownTextMenu(
            items: DownloadedAudioViewEnum.values,
            selectedItem: currentEnum,
            label: "Tür",
            onSelected: (DownloadedAudioViewEnum? newViewEnum){
              if(newViewEnum!=null){
                context.read<ManageAudioBloc>()
                    .add(ManageAudioEventChangeAudioViewType(newViewEnum));
              }
            }
          );
        });
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            "${audioEdition.name} ait indirilen ses dosyalarının yönetimi",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: onNavigateBack,
            icon: const Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}


