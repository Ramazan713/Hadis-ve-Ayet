import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/listen_audio_enum.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_bloc.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_event.dart';
import 'package:hadith/core/features/verse_audio/presentation/listen_basic_verse_audio/bloc/basic_audio_state.dart';


class BasicAudioPlayerContentWidget extends StatelessWidget {

  BasicAudioPlayerContentWidget({Key? key}) : super(key: key);

  final ValueNotifier<bool> _showSpeedNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 10,
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


extension AudioPlayerContentSliderExt on BasicAudioPlayerContentWidget{

  Widget getSlider(){
    return BlocBuilder<BasicAudioBloc,BasicAudioState>(
      buildWhen: (prevState,nextState){
        return (nextState.audioServiceState?.position.inSeconds??0) <= (nextState.audioServiceState?.duration.inSeconds??0);
      },
      builder: (context,state){

        final audioBloc = context.read<BasicAudioBloc>();

        return Slider(
          value: state.audioServiceState?.position.inSeconds.toDouble()??0,
          min: 0,
          max: state.audioServiceState?.duration.inSeconds.toDouble()??1,
          onChanged: (x){
            audioBloc.add(BasicAudioEventChangePosition(duration: Duration(seconds: x.toInt())));
          },
        );
      },
    );
  }
}


extension AudioPlayerContentBodyExt on BasicAudioPlayerContentWidget{

  Widget getBodyContent(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getSpeedIcon(),
            _getStartOrPauseIcon(),
            _getCancelIcon(context),
          ],
        ),
        Align(
            alignment: Alignment.centerRight,
            child: _getLoopIcon()
        )
      ],
    );
  }


  Widget _getSpeedIcon(){
    return BlocSelector<BasicAudioBloc, BasicAudioState,double>(
        selector: (state)=>state.audioServiceState?.speed??1,
        builder: (context,speed){
          return  TextButton(
              onPressed: () {
                _showSpeedNotifier.value = !_showSpeedNotifier.value;
              }, child: Text("${speed.toStringAsFixed(1)}x",style: Theme.of(context).textTheme.bodyMedium,));
        });
  }

  Widget _getStartOrPauseIcon(){
    return BlocSelector<BasicAudioBloc, BasicAudioState,ListenAudioEnum>(
        selector: (state)=>state.audioEnum,
        builder: (context,audioEnum){
          final audioBloc = context.read<BasicAudioBloc>();

          if(audioEnum == ListenAudioEnum.pause){
            return  IconButton(
                onPressed: () {
                  audioBloc.add(BasicAudioEventResume());
                },
                icon: const Icon(Icons.play_arrow));

          }else if(audioEnum == ListenAudioEnum.running){
            return IconButton(
                onPressed: () {
                  audioBloc.add(BasicAudioEventPause());
                },
                icon: const Icon(Icons.pause));
          }
          return const Icon(Icons.hourglass_empty);
        });
  }

  Widget _getCancelIcon(BuildContext context){
    final audioBloc = context.read<BasicAudioBloc>();

    return IconButton(
        onPressed: (){
          audioBloc.add(BasicAudioEventCancel());
        },
        icon: Icon(Icons.close,color: Theme.of(context).colorScheme.error,)
    );
  }

  Widget _getLoopIcon(){
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: BlocSelector<BasicAudioBloc, BasicAudioState,bool>(
        selector: (state)=>state.audioServiceState?.isLoop??false,
        builder: (context,isLoop){
          final audioBloc = context.read<BasicAudioBloc>();

          final icon = isLoop ? const Icon(Icons.repeat_one) : const Icon(Icons.repeat);
          return IconButton(onPressed: (){
            audioBloc.add(BasicAudioEventSetLoop(isLoop: !isLoop));
          }, icon: icon,tooltip: "loop",);
        }
      ),
    );
  }

}


extension AudioPlayerContentSpeedSliderExt on BasicAudioPlayerContentWidget{

  Widget getSpeedSlider(){
    return ValueListenableBuilder<bool>(
        valueListenable: _showSpeedNotifier,
        builder: (context,isVisible,child){
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: BlocSelector<BasicAudioBloc, BasicAudioState,double>(
                selector: (state)=>state.audioServiceState?.speed??1,
                builder: (context,speed){
                  if(!isVisible) return const SizedBox();

                  final audioBloc = context.read<BasicAudioBloc>();
                  return Slider(
                    value: speed,
                    onChanged: (newValue) {
                      audioBloc.add(BasicAudioEventChangeSpeed(newSpeed: newValue));
                    }, min: 0.5, max: 2.0,
                  );
                }),
          );
        }
    );
  }
}







