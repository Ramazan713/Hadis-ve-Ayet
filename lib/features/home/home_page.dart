
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import './sections/top_bar_section.dart';
import './sections/verse_content_section.dart';
import './sections/hadith_sitte_content_section.dart';
import './sections/hadith_serlevha_content_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AdaptiveLayout(
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            builder: (_){
              return getContent(context,1);
            },
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: (_){
              return getContent(context, 2);
            }
          )
        },
      ),
    );
  }

  Widget getContent(BuildContext context,int gridCount){

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
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
                  getVerseSection(context, gridCount),
                  const SizedBox(height: 32,),
                  getSerlevhaHadithSection(context, gridCount),
                  const SizedBox(height: 32,),
                  getSitteHadithSection(context, gridCount)
                ],
              ),
            ),
          ),
        ),
      )
    );
  }



}




