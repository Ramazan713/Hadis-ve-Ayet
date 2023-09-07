import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/counter_detail_setting/bloc/counter_setting_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/counter_detail_setting/bloc/counter_setting_state.dart';
import 'package:settings_ui/settings_ui.dart';

import 'bloc/counter_setting_bloc.dart';

class CounterDetailSettingPage extends StatelessWidget {

  const CounterDetailSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final counterSettingBloc = context.read<CounterSettingBloc>();
    counterSettingBloc.add(CounterSettingEventLoadData());

    return Scaffold(
      body: SafeArea(
        child: CustomNestedViewAppBar(
          title: const Text("Zikirmatik Ayarlar"),
          child: SettingsList(
            lightTheme: SettingsThemeData(
              settingsListBackground: Theme.of(context).colorScheme.surface,
            ),
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
