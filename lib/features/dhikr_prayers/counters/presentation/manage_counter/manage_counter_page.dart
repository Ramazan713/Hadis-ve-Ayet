import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/sections/content_section.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/sections/listener_section.dart';

import 'bloc/manage_counter_bloc.dart';
import 'bloc/manage_counter_event.dart';


class ManageCounterPage extends StatelessWidget {

  final int? counterId;

  ManageCounterPage({
    super.key,
    required this.counterId
  });

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController contentTextController = TextEditingController();
  final TextEditingController meaningTextController = TextEditingController();
  final TextEditingController arabicContentController = TextEditingController();
  final TextEditingController goalTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();

  final formKey = GlobalKey<FormBuilderState>();


  String get actionName => counterId == null ? "Oluştur" : "Güncelle";
  String get subtitle => counterId == null ? "Zikir" : "Zikri";

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<ManageCounterBloc>();
    bloc.add(ManageCounterEventLoadData(counterId: counterId));

    return getListeners(
      context: context,
      child: Scaffold(
        body: SafeArea(
          child: DefaultNestedScrollableAppBar(
            title: Text("$subtitle $actionName"),
            floating: true,
            snap: true,
            child: DefaultAdaptiveLayout(
              builder: (context, windowSizeClass){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              getAdaptiveSelectTypeWidget(context, windowSizeClass),
                              getNewContents(context, windowSizeClass: windowSizeClass),
                              getStandardAdaptiveBottomButton(context,windowSizeClass)
                            ],
                          ),
                        ),
                      ),
                      getExpandedAdaptiveBottomButton(context,windowSizeClass)
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getAdaptiveSelectTypeWidget(BuildContext context, WindowSizeClass windowSizeClass){
    if(!windowSizeClass.isExpanded){
      return getSelectTypeWidget(context, margins: const EdgeInsets.symmetric(vertical: 16, horizontal: 4));
    }
    return Row(
      children: [
        Flexible(
          child: getSelectTypeWidget(context, margins: const EdgeInsets.only(bottom: 12)),
        ),
        const Spacer()
      ],
    );
  }

  Widget getExpandedAdaptiveBottomButton(BuildContext context, WindowSizeClass windowSizeClass){
    if(windowSizeClass.isExpanded) return const SizedBox();
    return getBottomButton(context);
  }

  Widget getStandardAdaptiveBottomButton(BuildContext context, WindowSizeClass windowSizeClass){
    if(!windowSizeClass.isExpanded) return const SizedBox();
    return Row(
      children: [
        const Spacer(),
        Expanded(
          child: getBottomButton(context, margins: const EdgeInsets.only(top: 12, bottom: 12)),
        ),
        const Spacer(),
      ],
    );
  }

}

