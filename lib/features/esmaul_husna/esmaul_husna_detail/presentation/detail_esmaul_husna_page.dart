
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_bloc.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/bloc/detail_esmaul_husna_event.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/components/detail_esmaul_husna.dart';
import 'package:hadith/features/esmaul_husna/esmaul_husna_detail/presentation/sections/components_section.dart';

import 'bloc/detail_esmaul_husna_state.dart';

class DetailEsmaulHusnaPage extends StatefulWidget {

  final int initPos;

  const DetailEsmaulHusnaPage({
    Key? key,
    required this.initPos
  }) : super(key: key);

  @override
  State<DetailEsmaulHusnaPage> createState() => _DetailEsmaulHusnaPageState();
}

class _DetailEsmaulHusnaPageState extends State<DetailEsmaulHusnaPage> {
  late final PageController pageController;

  final CustomPositionController positionController = CustomPositionController();

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: widget.initPos);

    final bloc = context.read<DetailEsmaulHusnaBloc>();
    bloc.add(DetailEsmaulHusnaEventLoadData());

    positionController.setPositions(widget.initPos,widget.initPos,totalItems: bloc.state.items.length);
  }

  @override
  Widget build(BuildContext context) {


    return widget.getListeners(
      positionController: positionController,
      child: Scaffold(
          body: SafeArea(
            child: CustomNestedViewAppBar(
              title: const Text("Esmaul Husna"),
              floating: true,
              snap: true,
              actions: widget.getActions(context,pageController,positionController),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Column(
                  children: [
                    Expanded(
                      child: getContent(context),
                    ),
                    widget.getBottomButtons(context,pageController,positionController)
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  Widget getContent(BuildContext context){
    final bloc = context.read<DetailEsmaulHusnaBloc>();
    return BlocBuilder<DetailEsmaulHusnaBloc,DetailEsmaulHusnaState>(
      builder: (context,state){
        if(state.isLoading){
          return const SharedLoadingIndicator();
        }
        final items = state.items;
        if(items.isEmpty){
          return const SharedEmptyResult(
            content: "herhangi bir sonuç bulunamadı",
          );
        }
        return PageView.builder(
          onPageChanged: (page){
            positionController.setPositions(page, page,totalItems: items.length);
          },
          controller: pageController,
          itemBuilder: (context,index){
            final item = items[index];
            return DetailEsmaulHusna(
              esmaulHusna: item,
              fontModel: state.fontModel,
              onGotoDhikr: (){
                final counterId = item.counterId;
                if(counterId!=null){
                  DetailCounterRoute(id: counterId).push(context);
                }
              },
              onSaveAsDhikr: (){
                bloc.add(DetailEsmaulHusnaEventSaveAsDhikr(item: item));
              },
            );
          },
          itemCount: items.length,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    positionController.dispose();
  }

}
