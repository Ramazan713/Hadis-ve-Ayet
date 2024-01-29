
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import './sections/top_bar_section.dart';
import './sections/verse_content_section.dart';
import './sections/hadith_sitte_content_section.dart';
import './sections/hadith_serlevha_content_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultAdaptiveLayout(
      builder: (context, windowSizeClass){
        return SafeArea(
            child: Padding(
              padding: getPaddings(windowSizeClass),
              child: CustomNestedViewAppBar(
                floating: true,
                snap: true,
                actions: getActions(context),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5,bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        getSitteHadithSection(context)
                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }

  EdgeInsets getPaddings(WindowSizeClass windowSizeClass){
    switch(windowSizeClass){
      case WindowSizeClass.Compact:
        return const EdgeInsets.symmetric(horizontal: 4);
      case WindowSizeClass.Medium:
        return const EdgeInsets.symmetric(horizontal: 10);
      case WindowSizeClass.Expanded:
        return const EdgeInsets.symmetric(horizontal: 10);
    }
  }



}




