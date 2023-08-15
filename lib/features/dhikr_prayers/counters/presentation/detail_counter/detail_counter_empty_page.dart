import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_detail_event.dart';

import 'bloc/detail_counter_bloc.dart';
import 'detail_counter_shared_content_page.dart';


class DetailCounterEmptyPage extends StatelessWidget {

  final int counterTypeId;

  const DetailCounterEmptyPage({
    Key? key,
    required this.counterTypeId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DetailCounterBloc>()
        .add(DetailCounterEventLoadDataWithCounterType(counterType: CounterType.from(counterTypeId)));

    return const DetailCounterSharedContentPage(
        title: "Sayaç",
        hasCounter: false,
    );
  }
}








