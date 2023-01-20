

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/entities/audio_edition.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_bloc.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_event.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_state.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_model.dart';

import 'components/audio_manage_item.dart';
import 'components/dropdown_manage_enum_item.dart';


void showManageAudios(BuildContext context,{required AudioEdition edition}){
  final manageBloc = context.read<ManageAudioBloc>();

  manageBloc.add(ManageAudioEventSetIdentifier(edition.identifier));

  final ScrollController scrollController=ScrollController();


  showModalBottomSheet(
      context: context,
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
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
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

                                    Text("${edition.name} ait indirilen ses dosyalarının yönetimi",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Text("Tür: ",style: Theme.of(context).textTheme.bodyLarge,),
                                          const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 7),
                                              child: DropdownManageEnumItem()
                                          )
                                        ],
                                      ),
                                    ),
                                    BlocSelector<ManageAudioBloc,ManageAudioState,List<ManageAudioModel>>(
                                        selector: (state)=>state.manageModels,
                                        builder: (context,manageModels){

                                          if(manageModels.isEmpty){
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
                                              final item = manageModels[index];
                                              return  AudioManageItem(
                                                item: item,
                                                btnApproved: (){
                                                  manageBloc.add(ManageAudioEventDelete(item));
                                                },
                                              );
                                            },
                                            itemCount: manageModels.length,
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





