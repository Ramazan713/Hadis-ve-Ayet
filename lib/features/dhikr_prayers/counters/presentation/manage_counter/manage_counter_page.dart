import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/sections/content_section.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/manage_counter/sections/listener_section.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';

import 'bloc/manage_counter_bloc.dart';
import 'bloc/manage_counter_event.dart';
import 'bloc/manage_counter_state.dart';
import 'components/input_text_item.dart';
import 'components/select_counter.dart';


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


  String get actionName => counterId == null ? "Oluştur" : "Güncelle";

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<ManageCounterBloc>();
    bloc.add(ManageCounterEventLoadData(counterId: counterId));

    return getListeners(
      context: context,
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedViewAppBar(
            title: Text("Zikri $actionName"),
            floating: true,
            snap: true,
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
                          getContentFields(context),
                          getSelectTypeWidget(),
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
    );
  }
}

