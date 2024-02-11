import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/domain/enums/paging_status.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_state.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';

class LastPageVisibleItemWithPagination extends StatelessWidget {
  final Widget child;
  const LastPageVisibleItemWithPagination({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PaginationBloc, PaginationState, bool>(
      selector: (state) => state.currentPage >= state.totalStaticPages && state.status == PagingStatus.success,
      builder: (context, isVisible){
        return CustomAnimatedVisibility(
          visible: isVisible,
          child: child,
        );
      },
    );
  }
}
