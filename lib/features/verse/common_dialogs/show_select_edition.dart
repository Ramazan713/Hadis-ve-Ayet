import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/common_components/icon_play_audio.dart';
import 'package:hadith/features/verse/edition_bloc/edition_bloc.dart';
import 'package:hadith/features/verse/edition_bloc/edition_event.dart';
import 'package:hadith/features/verse/edition_bloc/edition_state.dart';
import 'package:hadith/features/verse/manage_audios/show_manage_audios.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/basic_audio_bloc/basic_audio_state.dart';
import 'package:hadith/utils/snack_utils.dart';

void showSelectEdition(BuildContext context){
  final editionBloc = context.read<EditionBloc>();

  editionBloc.add(EditionEventRefreshData());

  void setSelectionFunc(String identifier){
    editionBloc.add(EditionEventSetSelected(identifier: identifier));
  }

  showModalBottomSheet(context: context,
      isScrollControlled: true,
      builder: (context){

        return BlocListener<BasicAudioBloc,BasicAudioState>(
          listener: (context,state){
            if(state.message!=null){
              SnackUtils.showMessage(context, SnackBar(content: Text(state.message??"")));
            }
          },
          child: DraggableScrollableSheet(
            minChildSize: 0.2,
            initialChildSize: 0.5,
            maxChildSize: 1.0,
            expand: false,
            builder: (context,scrollControllerDraggable){
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.close))
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<EditionBloc,EditionState>(
                        builder: (context,state){
                          final items=state.items;
                          if(state.isLoading){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          if(items.isEmpty){
                            return const Text("Empty");
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            controller: scrollControllerDraggable,
                            itemBuilder: (context,index){
                              final item = items[index];
                              return Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                                margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(13),
                                  onTap: (){
                                    setSelectionFunc(item.identifier);
                                  },
                                  child: Row(
                                    children: [
                                      Radio<String>(value: item.identifier,
                                          groupValue: item.isSelected?item.identifier:"", onChanged: (newValue){
                                            if(newValue!=null){
                                              setSelectionFunc(newValue);
                                            }
                                          }),
                                      Expanded(child: Text(item.name)),
                                      IconPlayAudio(identifier: item.identifier,),
                                      IconButton(onPressed: ()async{
                                        showManageAudios(context,edition: item);
                                      }, icon: const Icon(Icons.arrow_forward)),

                                    ],
                                  ),
                                ),
                              );
                            },itemCount: state.items.length,);
                        }
                    ),
                  )
                ],
              );
            },
          ),
        );
      }
  ).then((value){
    context.read<BasicAudioBloc>().add(BasicAudioEventStopListening());
  });


}