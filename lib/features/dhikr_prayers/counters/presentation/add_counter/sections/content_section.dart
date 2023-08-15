
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/add_counter_page.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/bloc/add_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/bloc/add_counter_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/bloc/add_counter_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_counter/components/add_counter_item.dart';

extension AddCounterPageContentExt on AddCounterPage{

  Widget getManualAddButton(BuildContext context){
    return OutlinedButton(
        onPressed: () {
          AddNewCounterRoute().push(context);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          side: BorderSide(
              color: Theme.of(context).textTheme.bodyLarge?.color??Colors.white
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(
          "Manuel Ekle",
          style: Theme.of(context).textTheme.bodyLarge,
        )
    );
  }

  Widget getPrayersSection(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Listeden Ekle",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        getPrayersContent()
      ],
    );
  }

  Widget getPrayersContent(){
    return BlocBuilder<AddCounterBloc, AddCounterState>(
      builder: (context, state) {
        final items = state.items;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            final item = items[index];
            return AddCounterItem(
                item: item,
                onClick: () {
                  context.read<AddCounterBloc>()
                      .add(AddCounterEventAddCounter(prayer: item));
                }
            );
          },
        );
      },
    );
  }







}