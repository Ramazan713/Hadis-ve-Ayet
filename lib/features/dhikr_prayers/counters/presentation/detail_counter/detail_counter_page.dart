import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/core/domain/enums/paging_title_enum.dart';
import 'package:hadith/core/features/get_title/bloc/get_title_bloc.dart';
import 'package:hadith/core/features/get_title/bloc/get_title_event.dart';
import 'package:hadith/core/features/get_title/bloc/get_title_state.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/dialogs/show_select_verse_ui_3x.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/detail_counter/bloc/detail_detail_event.dart';
import 'package:hadith/features/extra_features/counter/domain/counter_type.dart';
import 'package:hadith/features/extra_features/counter/domain/model/counter.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_bloc.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_event.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/bloc/counter_detail_state.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_complete_goal_item.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_content.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_content_with_child.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_detail_select_menu.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/dhikrmatic_classic.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/dhikrmatic_unlimited.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/show_counter_goal_progress.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/model/counter_detail_param.dart';
import 'package:hadith/features/verse/verse_helper_funcs.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/utils/snack_utils.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_appbar.dart';
import 'package:hadith/widgets/app_bar/custom_sliver_nested_scrollview.dart';
import 'package:tuple/tuple.dart';

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








