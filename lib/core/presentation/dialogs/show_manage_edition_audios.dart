

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
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

  final manageBloc = context.read<ManageAudioBloc>();
  manageBloc.add(ManageAudioEventLoadData(identifier: audioEdition.identifier));

  final ScrollController scrollController = ScrollController();

  void onNavigateBack(){
    Navigator.of(context,rootNavigator: useRootNavigator).pop();
  }

  Widget getDropdownMenu(){
    return BlocSelector<ManageAudioBloc,ManageAudioState,DownloadedAudioViewEnum?>(
        selector: (state)=>state.selectedEnum,
        builder: (context,currentEnum){
          return DropdownButton<DownloadedAudioViewEnum>(
              items: DownloadedAudioViewEnum.values.map((viewEnum){
                return DropdownMenuItem(
                  value: viewEnum,
                  child: Text(viewEnum.description),
                );
              }).toList(),
              value: currentEnum,
              onChanged: (DownloadedAudioViewEnum? newViewEnum){
                if(newViewEnum!=null){
                  manageBloc.add(ManageAudioEventChangeAudioViewType(newViewEnum));
                }
              }
          );
        });
  }

  Widget getHeader(){
    return Column(
      children: [
        Text(
            "${audioEdition.name} ait indirilen ses dosyalarının yönetimi",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text("Tür: ",style: Theme.of(context).textTheme.bodyLarge,),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: getDropdownMenu()
              )
            ],
          ),
        )
      ],
    );
  }




  showModalBottomSheet(
      context: context,
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      builder: (context){
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 1,
          builder: (context,draggableScrollController){

            return SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: onNavigateBack,
                      icon: const Icon(Icons.close),
                    ),
                  ),

                  Expanded(
                    child: CustomScrollView(
                      shrinkWrap: true,
                      controller: draggableScrollController,
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                              [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 7),
                                  child: Column(
                                    children: [
                                      getHeader(),
                                      BlocBuilder<ManageAudioBloc,ManageAudioState>(
                                        buildWhen: (prevState, nextState){
                                          return prevState.models != nextState.models;
                                        },
                                        builder: (context,state){
                                          final models = state.models;

                                          if(models.isEmpty){
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 13),
                                              child: Center(
                                                child: Text("İndirilmiş herhangi bir ses dosyası bulunamadı",style: Theme.of(context).textTheme.titleMedium,),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            controller: scrollController,
                                            shrinkWrap: true,
                                            itemBuilder: (context,index){
                                              final item = models[index];
                                              return DownloadedAudioViewItem(
                                                model: item,
                                                onDeletePressed: (){
                                                  showCustomAlertBottomDia(
                                                      context,
                                                      title: "Silmek istediğinize emin misiniz?",
                                                      content: "Bu işlem geri alınamaz",
                                                      btnApproved: (){
                                                        manageBloc.add(ManageAudioEventDelete(item));
                                                      }
                                                  );
                                                },
                                              );
                                            },
                                            itemCount: models.length,
                                          );
                                        })
                                    ],
                                  ),
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      });

}