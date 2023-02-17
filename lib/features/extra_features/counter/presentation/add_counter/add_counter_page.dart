import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/add_counter/components/add_counter_item.dart';
import 'package:hadith/features/extra_features/counter/presentation/manage_counter/manage_counter_page.dart';
import 'package:hadith/utils/snack_utils.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';

import '../../domain/model/counter.dart';
import 'bloc/add_counter_bloc.dart';
import 'bloc/add_counter_event.dart';
import 'bloc/add_counter_state.dart';

class AddCounterPage extends StatelessWidget {
  static const id = "AddCounterPage";

  AddCounterPage({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddCounterBloc>();
    return Scaffold(
      body: SafeArea(
        child: CustomSliverNestedView(
          context,
          isBottomNavAffected: false,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const CustomSliverAppBar(
                floating: true,
                snap: true,
                title: Text("Zikir Ekle"),
              )
            ];
          },
          child: BlocListener<AddCounterBloc, AddCounterState>(
            listener: (context, state) {
              if (state.message != null) {
                SnackUtils.showMessage(
                    context, SnackBar(content: Text(state.message ?? "")));
              }
              if (state.navigationPop) {
                Navigator.pop(context);
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ManageCounterPage.id);
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
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Listeden Ekle",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        BlocBuilder<AddCounterBloc, AddCounterState>(
                          builder: (context, state) {
                            final items = state.counters;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return AddCounterItem(
                                    counter: item,
                                    onClick: () {
                                      bloc.add(AddCounterEventAddCounter(counter: item));
                                    });
                              },
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


