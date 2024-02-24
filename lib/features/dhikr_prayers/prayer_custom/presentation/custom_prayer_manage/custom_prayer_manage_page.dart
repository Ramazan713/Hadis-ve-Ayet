import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/features/adaptive/presentation/default_adaptive_layout.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import './sections/content_section.dart';
import './sections/listener_section.dart';
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
              useAdaptivePadding: true,
              builder: (context, windowSizeClass){
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: getBottomButton(context),
                      ),
                      Flexible(
                        child: Padding(
                          padding: K.defaultLazyListPadding,
                          child: getContents(context, windowSizeClass: windowSizeClass),
                        ),
                      ),
                    ],
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

