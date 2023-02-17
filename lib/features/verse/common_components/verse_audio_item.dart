import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/constants/audio_enum.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_bloc.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_event.dart';
import 'package:hadith/features/verse/verse_listen_audio/bloc/verse_audio_state.dart';

class VerseAudioItem extends StatelessWidget {

  final Function()?onBookmarkClick;

  VerseAudioItem({Key? key,this.onBookmarkClick}) : super(key: key);

  final ValueNotifier<bool>_showSpeedNotifier=ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<VerseAudioBloc>();

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
            color: Theme.of(context).bottomAppBarColor,
            child: Wrap(
              children: [
                Column(
                  children: [
                    BlocBuilder<VerseAudioBloc,VerseAudioState>(
                      buildWhen: (prevState,nextState){
                        return (nextState.currentAudio?.position.inSeconds??0) <= (nextState.currentAudio?.duration.inSeconds??0);
                      },
                      builder: (context,state){
                        return  Slider(
                          value: state.currentAudio?.position.inSeconds.toDouble()??0,
                          min: 0,
                          max: state.currentAudio?.duration.inSeconds.toDouble()??1,
                          onChanged: (x){
                            audioBloc.add(AudioEventChangePosition(duration: Duration(seconds: x.toInt())));
                          },
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getBookmarkWidget(),
                        const Spacer(flex: 2),
                        BlocSelector<VerseAudioBloc,VerseAudioState,double>(
                            selector: (state)=>state.currentAudio?.speed??1,
                            builder: (context,speed){
                              return  TextButton(
                                  onPressed: () {
                                    _showSpeedNotifier.value = !_showSpeedNotifier.value;
                                  }, child: Text("${speed.toStringAsFixed(1)}x",style: Theme.of(context).textTheme.bodyMedium,));
                            }),
                        BlocSelector<VerseAudioBloc,VerseAudioState,AudioEnum>(
                            selector: (state)=>state.getAudioEnum(),
                            builder: (context,audioEnum){
                              return getStartPauseIcon(audioBloc, audioEnum);
                            }),
                        IconButton(onPressed: (){
                          audioBloc.add(AudioEventStop());
                        }, icon: Icon(Icons.close,color: Theme.of(context).errorColor,)),
                        const Spacer(flex: 2),
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: BlocSelector<VerseAudioBloc,VerseAudioState,bool>(
                              selector: (state)=>state.currentAudio?.isLoop??false,
                              builder: (context,isLoop){
                                final icon = isLoop ? const Icon(Icons.repeat_one) : const Icon(Icons.repeat);
                                return IconButton(onPressed: (){
                                  audioBloc.add(AudioEventSetLoop(isLoop: !isLoop));

                                }, icon: icon,tooltip: "loop",);
                              }
                          ),
                        )
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: _showSpeedNotifier,
                        builder: (context,isVisible,child){
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: BlocSelector<VerseAudioBloc,VerseAudioState,double>(
                                selector: (state)=>state.currentAudio?.speed??1,
                                builder: (context,speed){
                                  return !isVisible ? const SizedBox() : Slider(
                                    value: speed,
                                    onChanged: (newValue) {
                                      audioBloc.add(AudioEventChangeSpeed(newSpeed: newValue));
                                    }, min: 0.5, max: 2.0,
                                  );
                                }),
                          );
                        }
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getStartPauseIcon(VerseAudioBloc audioBloc, AudioEnum audioEnum) {

    if(audioEnum == AudioEnum.pause){
      return  IconButton(
          onPressed: () {
            audioBloc.add(AudioEventResume());
          },
          icon: const Icon(Icons.play_arrow));
    }else if(audioEnum == AudioEnum.running){
      return IconButton(
          onPressed: () {
            audioBloc.add(AudioEventPause());
          },
          icon: const Icon(Icons.pause));
    }
    return const Icon(Icons.hourglass_empty);
  }

  Widget getBookmarkWidget(){
    if(onBookmarkClick == null){
      return const SizedBox();
    }
    return BlocSelector<VerseAudioBloc,VerseAudioState,int?>(
        selector: (state)=>state.currentSavePointId(),
        builder: (context,savepointId){
          final iconData = savepointId!=null?Icons.bookmark_added:Icons.bookmark_add;
          return Padding(
            padding: const EdgeInsets.only(left: 7),
            child: IconButton(
              onPressed: onBookmarkClick,
              icon: Icon(iconData),
            ),
          );
        });
  }


}