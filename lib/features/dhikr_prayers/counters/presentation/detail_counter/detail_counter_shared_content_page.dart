
import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/features/ads/ad_check_widget.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import './sections/top_bar_section.dart';
import './sections/counter_content_section.dart';
import './sections/dhikr_content_section.dart';

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

    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: DefaultNestedScrollableAppBar(
            actions: getActions(context),
            title: Text(title),
            child: DefaultAdaptiveLayout(
              useAdaptivePadding: true,
              builder: (context, windowSizeClass){
                return CustomScrollView(
                  slivers: [
                    SliverList.list(
                      children: [
                        getCounterContent(windowSizeClass)
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
