import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/components/add_counter_item.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/sections/content_section.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/sections/listener_section.dart';
import 'package:hadith/utils/toast_utils.dart';

import 'bloc/add_counter_bloc.dart';
import 'bloc/add_counter_event.dart';
import 'bloc/add_counter_state.dart';

class AddCounterPage extends StatelessWidget {

  AddCounterPage({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return getListeners(
      context: context,
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedViewAppBar(
            title: const Text("Zikir Ekle"),
            snap: true,
            floating: true,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getManualAddButton(context),
                    const SizedBox(
                      height: 100,
                    ),
                    getPrayersSection(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


