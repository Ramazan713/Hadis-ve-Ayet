import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_bloc.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_event.dart';
import 'package:hadith/core/features/manage_downloaded_audio/bloc/manage_downloaded_audio_state.dart';
import 'package:hadith/core/utils/toast_utils.dart';

class ManageDownloadedAudioListener extends StatelessWidget {

  final Widget child;

  const ManageDownloadedAudioListener({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageAudioBloc, ManageAudioState>(
      listener: (context, state){
        final message = state.message;
        if(message!=null){
          ToastUtils.showLongToast(message);
          context.read<ManageAudioBloc>().add(ManageAudioEventClearMessage());
        }
      },
      child: child,
    );
  }
}
