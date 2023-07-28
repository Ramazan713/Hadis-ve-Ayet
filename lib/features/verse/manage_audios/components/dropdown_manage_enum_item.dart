

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/manage_audios/audio_manage_enum.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_bloc.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_event.dart';
import 'package:hadith/features/verse/manage_audios/bloc/manage_audio_state.dart';

class DropdownManageEnumItem extends StatelessWidget {
  const DropdownManageEnumItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manageBloc = context.read<ManageAudioBlocOld>();

    return BlocSelector<ManageAudioBlocOld,ManageAudioStateOld,AudioManageEnum>(
        selector: (state)=>state.manageEnum,
        builder: (context,currentEnum){
          return DropdownButton<AudioManageEnum>(
              items: AudioManageEnum.values.map((manageEnum){
                return DropdownMenuItem(
                  child: Text(manageEnum.description),
                  value: manageEnum,
                );
              }).toList(),
              value: currentEnum,
              onChanged: (AudioManageEnum? newManageEnum){
                if(newManageEnum!=null){
                  manageBloc.add(ManageAudioEventChangeType(newManageEnum));
                }
              }
          );
        });
  }
}