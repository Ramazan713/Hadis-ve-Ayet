
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/category/sections/content_section.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAdaptiveLayout(
      builder: (context, windowSizeClass){
        final expandContent = !windowSizeClass.isCompact;
        return Scaffold(
          body: SafeArea(
            child: CustomNestedViewAppBar(
              floating: true,
              snap: true,
              actions: getActions(context),
              title: const Text("Kategoriler"),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getDhikrCollection(context, expandContent),
                    getEsmaulHusnaCollection(context, expandContent),
                    getPrayerAndVerseCollection(context, expandContent),
                    getIslamicInfoCollection(context, expandContent)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> getActions(BuildContext context){
    return [
      IconButton(
        onPressed: () {
          SettingsRoute().push(context);
        },
        icon: const Icon(Icons.settings),
        tooltip: "Ayarlar",
      )
    ];
  }
}



