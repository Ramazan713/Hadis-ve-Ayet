import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/dialogs/show_select_verse_ui_3x.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_event.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_state.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_complete_goal_item.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_content.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_content_with_child.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_detail_select_menu.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/dhikrmatic_classic.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/dhikrmatic_unlimited.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/show_counter_goal_progress.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/model/counter_detail_param.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/utils/snack_utils.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:tuple/tuple.dart';

class CounterDetailPage extends StatelessWidget {
  static const id = "CounterDetailPage";

  const CounterDetailPage({Key? key}) : super(key: key);


  List<Widget> getContent(BuildContext context,CounterDetailState state){
    final counter = state.counter;
    final fontSize = state.fontSize;
    if(counter == null){
      return [];
    }
    final items = <Widget> [];
    if(counter.goal!=null ){
      items.add(
          ShowCounterGoalProgress(goal: counter.goal??1,)
      );
    }
    if(state.verseUi3X.arabicVisible && counter.arabicContent!=null && counter.arabicContent!=""){
      items.add(CounterContentWithChild(
        title: "Arapça İçerik",
        fontSize: fontSize,
        child: getArabicRichWidget(
            counter.arabicContent??"",
            fontSize,
            style: Theme.of(context).textTheme.bodyMedium
        ),
      ));
    }
    if(state.verseUi3X.pronunciationVisible && counter.content!=null && counter.content!=""){
      items.add(CounterContent(
          title: "İçerik",
          fontSize: fontSize,
          content: counter.content??""
      ));
    }

    if(state.verseUi3X.mealVisible && counter.meaning!=null && counter.meaning!=""){
      items.add(CounterContent(
          title: "Anlamı",
          fontSize: fontSize,
          content: counter.meaning??""
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {

    final param = (ModalRoute.of(context)?.settings.arguments as CounterDetailParam?) ??
        CounterDetailParam.defaultParam();

    final counterBloc = context.read<CounterDetailBloc>();
    counterBloc.add(CounterDetailEventSetInit(counter: param.counter,counterType: param.type));
    return Scaffold(
      body: SafeArea(
        child: CustomSliverNestedView(
          context,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              CustomSliverAppBar(
                title: Text((param.counter?.name)??"Sayaç"),
                actions: [
                  BlocSelector<CounterDetailBloc,CounterDetailState,bool>(
                      selector: (state)=>state.hasAnyContent(),
                      builder: (context,hasAnyContent){
                        if(!hasAnyContent){
                          return const SizedBox();
                        }
                        return IconButton(
                          onPressed: () async{
                            showSelectVerseUi3X(context,
                              prefKeyType: PrefConstants.counterUi,
                              callback: (selected){
                                counterBloc.add(CounterDetailEventSetCounterUi(counterUi: selected));
                              }
                            );
                          },
                          icon: const Icon(Icons.view_agenda),
                          tooltip: "Görünümü Değiştir",
                        );
                      }
                  ),
                  const CounterDetailSelectMenu()
                ],
              )
            ];
          },
          child: BlocListener<CounterDetailBloc,CounterDetailState>(
            listener: (context,state){
              if(state.message!=null){
                SnackUtils.showMessage(context, SnackBar(content: Text(state.message??"")));
              }
            },
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          BlocBuilder<CounterDetailBloc,CounterDetailState>(
                            buildWhen: (prevState,nextState){
                              return (prevState.fontSize!=nextState.fontSize) ||
                                  (prevState.counter!=nextState.counter) ||
                                  (prevState.verseUi3X != nextState.verseUi3X);
                            },
                            builder: (context,state){
                              return Column(
                                children: getContent(context,state),
                              );
                            },
                          )
                        ]
                    )
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 13,),
                      const Spacer(flex: 3,),
                      BlocBuilder<CounterDetailBloc,CounterDetailState>(
                        builder: (context,state){
                          return state.counterType == CounterType.classic ?
                          DhikrmaticClassic(
                            counter: state.counterClassic,
                            subCounter: state.counterSubClassic,
                            onClick: (){
                              counterBloc.add(CounterDetailEventIncrease());
                            },
                          ):
                          DhikrmaticUnLimited(
                            counter: state.counterUnLimited,
                            onClick: (){
                              counterBloc.add(CounterDetailEventIncrease());
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 5,),
                      BlocSelector<CounterDetailBloc,CounterDetailState,bool>(
                          selector: (state)=>state.hasCompletedGoal,
                          builder: (context,goalCompleted){
                            if(goalCompleted){
                              return const CounterCompleteGoalItem();
                            }
                            return const SizedBox();
                          }
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}








