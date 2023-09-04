import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
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
          child: CustomNestedViewAppBar(
            title: Text("$subtitle $actionName"),
            floating: true,
            snap: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            getSelectTypeWidget(context),
                            getNewContents(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  getBottomButton(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

