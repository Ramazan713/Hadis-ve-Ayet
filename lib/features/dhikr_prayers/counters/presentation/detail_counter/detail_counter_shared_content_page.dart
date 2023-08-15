
import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/sections/counter_content_section.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/sections/dhikr_content_section.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/sections/top_bar_section.dart';


class DetailCounterSharedContentPage extends StatelessWidget {

  final String title;
  final bool hasCounter;

  const DetailCounterSharedContentPage({
    Key? key,
    required this.title,
    required this.hasCounter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          actions: getActions(context),
          title: Text(title),
          child: CustomScrollView(
            slivers: [
              SliverList.list(
                children: [
                  getCounterContent()
                ],
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 13,),
                    const Spacer(flex: 3,),
                    getDhikr(),
                    const SizedBox(height: 8,),
                    getCompletedWidget(),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
