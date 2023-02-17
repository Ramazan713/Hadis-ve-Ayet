import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail_setting/bloc/counter_setting_event.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail_setting/bloc/counter_setting_state.dart';
import 'package:hadith/themes/custom/get_setting_theme.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:settings_ui/settings_ui.dart';

import 'bloc/counter_setting_bloc.dart';

class CounterDetailSettingPage extends StatelessWidget {
  static const id = "CounterDetailSettingPage";

  const CounterDetailSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final counterSettingBloc = context.read<CounterSettingBloc>();
    counterSettingBloc.add(CounterSettingEventSetInit());

    return Scaffold(
      body: SafeArea(
        child: CustomSliverNestedView(context,
          headerSliverBuilder:  (BuildContext context, bool innerBoxIsScrolled){
            return [
              const CustomSliverAppBar(
                title: Text("Zikirmatik Ayarlar"),
              )
            ];
          },
          child: SettingsList(
            lightTheme: getSettingThemeData(context),
            sections: [
              SettingsSection(
                tiles: [
                  CustomSettingsTile(
                    child: BlocSelector<CounterSettingBloc,CounterSettingState,bool>(
                      selector: (state)=>state.eachDhikrVibration,
                      builder: (context,eachDhikrVibration){
                        return SettingsTile.switchTile(
                          initialValue: eachDhikrVibration,
                          onToggle: (newValue){
                            counterSettingBloc.add(CounterSettingEventSetEachDhikrVibration(
                                eachDhikrVibration: newValue));
                          },
                          title: const Text("Her zikir için titreşim"),
                        );
                      },
                    ),
                  ),
                  CustomSettingsTile(
                    child: BlocSelector<CounterSettingBloc,CounterSettingState,bool>(
                      selector: (state)=>state.eachEndOfTourVibration,
                      builder: (context,eachEndOfTourVibration){
                        return SettingsTile.switchTile(
                          initialValue: eachEndOfTourVibration,
                          onToggle: (newValue){
                            counterSettingBloc.add(CounterSettingEventSetEndOfVibration(
                                endOfVibration: newValue));
                          },
                          title: const Text("Tur sonları veya hedef sonları için titreşim"),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
