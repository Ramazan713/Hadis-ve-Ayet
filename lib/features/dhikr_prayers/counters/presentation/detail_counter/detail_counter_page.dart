import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/features/get_title/bloc/get_title_bloc.dart';
import 'package:hadith/core/features/get_title/bloc/get_title_event.dart';
import 'package:hadith/core/features/get_title/bloc/get_title_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_detail_event.dart';

import 'bloc/detail_counter_bloc.dart';
import 'detail_counter_shared_content_page.dart';

class DetailCounterPage extends StatelessWidget {

  final int counterId;

  const DetailCounterPage({
    Key? key,
    required this.counterId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<DetailCounterBloc>()
        .add(DetailCounterEventLoadDataWithCounterId(counterId: counterId));

    context.read<GetTitleBloc>()
        .add(GetTitleEventRequestTitle(itemId: counterId, titleEnum: TitleEnum.counter));

    return BlocBuilder<GetTitleBloc,GetTitleState>(
      builder: (context, state){
        return DetailCounterSharedContentPage(
            title: state.title ?? "Sayaç",
            hasCounter: true,
        );
      },
    );
  }
}








