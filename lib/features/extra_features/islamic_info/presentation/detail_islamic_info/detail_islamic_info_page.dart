import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/constant/islamic_info_type.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/bloc/detail_islamic_info_bloc.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/bloc/detail_islamic_info_state.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/components/info_title_item.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/info_page_param.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:hadith/widgets/title_text_item.dart';
import 'package:hadith/features/app/ads/ad_check_widget.dart';

import 'bloc/detail_islamic_info_event.dart';

class DetailIslamicInfoPage extends StatelessWidget {
  static const id = "DetailIslamicInfoPage";

  DetailIslamicInfoPage({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final type =
        (ModalRoute.of(context)?.settings.arguments as InfoPageParam?) ??
            InfoPageParam.defaultParam();
    context
        .read<DetailIslamicInfoBloc>()
        .add(DetailIslamicInfoEventSetInit(infoType: type.infoType));

    return AdCheckWidget(
      child: Scaffold(
        body: SafeArea(
          child: CustomSliverNestedView(
            context,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                CustomSliverAppBar(
                  snap: true,
                  floating: true,
                  title: Text(type.infoType.title),
                )
              ];
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                child: Column(
                  children: [
                    TitleTextItem(
                      title: "Konu: ",
                      content: type.infoType.title,
                      contentTextStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                    BlocBuilder<DetailIslamicInfoBloc, DetailIslamicInfoState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final items = state.items;
                        if (items.isEmpty) {
                          return const Text("empty");
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return InfoTitleItem(
                              info: item,
                              itemAxis: type.itemAxis,
                              scrollController: scrollController,
                            );
                          },
                        );
                      },
                    ),
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


