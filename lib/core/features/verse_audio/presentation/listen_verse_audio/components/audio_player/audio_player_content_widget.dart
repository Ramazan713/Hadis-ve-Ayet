import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/listen_audio_enum.dart';

import '../../bloc/verse_audio_bloc.dart';
import '../../bloc/verse_audio_event.dart';
import '../../bloc/verse_audio_state.dart';

class AudioPlayerContentWidget extends StatelessWidget {

  final Function()? onSavePointClick;

  AudioPlayerContentWidget({
    Key? key,
    this.onSavePointClick
  }) : super(key: key);

  final ValueNotifier<bool> _showSpeedNotifier=ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SliderTheme(
          data: const SliderThemeData(
            trackHeight: 1.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
          ),
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Wrap(
              children: [
                Column(
                  children: [
                    getSlider(),
                    getBodyContent(context),
                    getSpeedSlider()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


extension AudioPlayerContentSliderExt on AudioPlayerContentWidget{

  Widget getSlider(){
    return BlocBuilder<ListenVerseAudioBloc,ListenVerseAudioState>(
      buildWhen: (prevState,nextState){
        return (nextState.serviceState?.position.inSeconds??0) <= (nextState.serviceState?.duration.inSeconds??0);
      },
      builder: (context,state){

        final audioBloc = context.read<ListenVerseAudioBloc>();

        return Slider(
          value: state.serviceState?.position.inSeconds.toDouble()??0,
          min: 0,
          max: state.serviceState?.duration.inSeconds.toDouble()??1,
          onChanged: (x){
            audioBloc.add(ListenAudioEventChangePosition(duration: Duration(seconds: x.toInt())));
          },
        );
      },
    );
  }
}


extension AudioPlayerContentBodyExt on AudioPlayerContentWidget{

  Widget getBodyContent(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getSavePointIcon(),
        const Spacer(flex: 2),
        _getSpeedIcon(),
        _getStartOrPauseIcon(),
        _getCancelIcon(context),
        const Spacer(flex: 2),
        _getLoopIcon()
      ],
    );
  }

  Widget _getSavePointIcon(){
    if(onSavePointClick == null){
      return const SizedBox();
    }
    return BlocSelector<ListenVerseAudioBloc,ListenVerseAudioState,int?>(
        selector: (state)=> state.currentSavePointId,
        builder: (context,savepointId){

          final iconData = savepointId!=null?Icons.bookmark_added:Icons.bookmark_add;
          return Padding(
            padding: const EdgeInsets.only(left: 7),
            child: IconButton(
              onPressed: onSavePointClick,
              icon: Icon(iconData),
            ),
          );
        });
  }

  Widget _getSpeedIcon(){
    return BlocSelector<ListenVerseAudioBloc, ListenVerseAudioState,double>(
        selector: (state)=>state.serviceState?.speed??1,
        builder: (context,speed){
          return  TextButton(
              onPressed: () {
                _showSpeedNotifier.value = !_showSpeedNotifier.value;
              }, child: Text("${speed.toStringAsFixed(1)}x",style: Theme.of(context).textTheme.bodyMedium,));
        });
  }

  Widget _getStartOrPauseIcon(){
    return BlocSelector<ListenVerseAudioBloc, ListenVerseAudioState,ListenAudioEnum>(
        selector: (state)=>state.audioEnum,
        builder: (context,audioEnum){
          final audioBloc = context.read<ListenVerseAudioBloc>();

          if(audioEnum == ListenAudioEnum.pause){
            return  IconButton(
                onPressed: () {
                  audioBloc.add(ListenAudioEventResume());
                },
                icon: const Icon(Icons.play_arrow));

          }else if(audioEnum == ListenAudioEnum.running){
            return IconButton(
                onPressed: () {
                  audioBloc.add(ListenAudioEventPause());
                },
                icon: const Icon(Icons.pause));
          }
          return const Icon(Icons.hourglass_empty);
        });
  }

  Widget _getCancelIcon(BuildContext context){
    final audioBloc = context.read<ListenVerseAudioBloc>();

    return IconButton(
        onPressed: (){
          audioBloc.add(ListenAudioEventStop());
        },
        icon: Icon(Icons.close,color: Theme.of(context).colorScheme.error,)
    );
  }

  Widget _getLoopIcon(){
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: BlocSelector<ListenVerseAudioBloc, ListenVerseAudioState,bool>(
          selector: (state)=>state.serviceState?.isLoop??false,
          builder: (context,isLoop){
            final audioBloc = context.read<ListenVerseAudioBloc>();

            final icon = isLoop ? const Icon(Icons.repeat_one) : const Icon(Icons.repeat);
            return IconButton(onPressed: (){
              audioBloc.add(ListenAudioEventSetLoop(isLoop: !isLoop));
            }, icon: icon,tooltip: "loop",);
          }
      ),
    );
  }

}


extension AudioPlayerContentSpeedSliderExt on AudioPlayerContentWidget{

  Widget getSpeedSlider(){
    return ValueListenableBuilder<bool>(
        valueListenable: _showSpeedNotifier,
        builder: (context,isVisible,child){
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: BlocSelector<ListenVerseAudioBloc, ListenVerseAudioState,double>(
                selector: (state)=>state.serviceState?.speed??1,
                builder: (context,speed){
                  if(!isVisible) return const SizedBox();

                  final audioBloc = context.read<ListenVerseAudioBloc>();
                  return Slider(
                    value: speed,
                    onChanged: (newValue) {
                      audioBloc.add(ListenAudioEventChangeSpeed(newSpeed: newValue));
                    }, min: 0.5, max: 2.0,
                  );
                }),
          );
        }
    );
  }
}







