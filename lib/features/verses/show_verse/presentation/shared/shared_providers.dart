import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/pagination/presentation/bloc/pagination_bloc.dart';

class VerseSharedProviders extends StatelessWidget {
  final Widget child;

  const VerseSharedProviders({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaginationBloc(),
      child: child,
    );
  }
}
