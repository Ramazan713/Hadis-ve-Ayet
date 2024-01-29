import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hadith/core/features/adaptive/domain/enums/window_size_class.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_manage/sections/content_section.dart';
import 'package:hadith/features/dhikr_prayers/prayer_custom/presentation/custom_prayer_manage/sections/listener_section.dart';
import 'bloc/custom_prayer_manage_bloc.dart';
import 'bloc/custom_prayer_manage_event.dart';


class CustomPrayerManagePage extends StatelessWidget {

  final int? prayerId;

  CustomPrayerManagePage({
    super.key,
    required this.prayerId
  });

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController contentTextController = TextEditingController();
  final TextEditingController meaningTextController = TextEditingController();
  final TextEditingController arabicContentController = TextEditingController();
  final TextEditingController sourceTextController = TextEditingController();

  final formKey = GlobalKey<FormBuilderState>();


  String get actionName => prayerId == null ? "Oluştur" : "Güncelle";
  String get subtitle => "Dua";

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<CustomPrayerManageBloc>();
    bloc.add(CustomPrayerManageEventLoadData(prayerId: prayerId));

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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: getBottomButton(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: getContents(context, windowSizeClass: windowSizeClass),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

