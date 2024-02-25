
import 'package:flutter/material.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import './sections/hadith_serlevha_content_section.dart';
import './sections/hadith_sitte_content_section.dart';
import './sections/top_bar_section.dart';
import './sections/verse_content_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAdaptiveLayout(
      useAdaptivePadding: true,
      builder: (context, windowSizeClass){
        return SafeArea(
          child: DefaultNestedScrollableAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 76,
            scrolledUnderElevation: 0,
            actions: getActions(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7,right: 7,top: 16),
                    child: Text(
                      "Hadis ve Ayet",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  getVerseSection(context),
                  const SizedBox(height: 32,),
                  getSerlevhaHadithSection(context),
                  const SizedBox(height: 32,),
                  getSitteHadithSection(context),
                  const SizedBox(height: 16,)
                ],
              ),
            ),
          )
        );
      },
    );
  }
}




