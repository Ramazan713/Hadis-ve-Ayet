

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/core/domain/enums/downloaded_audio_view_enum.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_state.dart';
import 'package:hadith/core/features/manage_downloaded_audio/components/downloaded_audio_view_item.dart';

void showManageDownloadedAudios(BuildContext context,{bool useRootNavigator = true}){

  final manageBloc = context.read<ManageAudioBloc>();
  manageBloc.add(ManageAudioEventLoadData(identifier: null));

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

  Widget getHeader(BuildContext context){
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 48,),
            Expanded(
                child: Text(
                  "indirilen ses dosyalarının yönetimi",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                )
            ),
            IconButton(
              onPressed: onNavigateBack,
              icon: const Icon(Icons.close),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Align(
              alignment: Alignment.centerLeft,
              child: getDropdownMenu()
          ),
        )
      ],
    );
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

            return SafeArea(
              child: SingleChildScrollView(
                controller: draggableScrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 7),
                  child: Column(
                    children: [
                      getHeader(context),
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
                              controller: draggableScrollController,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                final item = models[index];
                                return DownloadedAudioViewItem(
                                  model: item,
                                  showEditionName: true,
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
              ),
            );
          },
        );
      }
  );

}