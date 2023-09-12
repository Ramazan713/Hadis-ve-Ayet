
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_ready_counter/bloc/add_ready_counter_bloc.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_ready_counter/bloc/add_ready_counter_event.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_ready_counter/bloc/add_ready_counter_state.dart';
import 'package:hadith/features/dhikr_prayers/counters/presentation/add_ready_counter/components/add_counter_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';
import 'package:hadith/utils/toast_utils.dart';

void showAddCounterDia<T extends IDetailItem>(BuildContext context){

  context.read<AddReadyCounterBloc>().add(AddReadyCounterEventLoadData());

  showBottomSheetHandler(
    context: context,
    child: DraggableScrollableSheet(
        minChildSize: 0.4,
        initialChildSize: 0.7,
        maxChildSize: 0.99,
        snap: true,
        snapSizes: const [
          0.5,0.75,0.99
        ],
        expand: false,
        builder: (context, controller){
          return  _DialogContent(
            controller: controller,
            onCancel: (){
              Navigator.of(context,rootNavigator: false).pop();
            },
          );
        }
      )
  );

}


class _DialogContent<T extends IDetailItem> extends StatefulWidget {
  
  final String? title;
  final void Function() onCancel;
  final ScrollController controller;

  const _DialogContent({
    Key? key,
    this.title,
    required this.onCancel,
    required this.controller
  }) : super(key: key);

  @override
  State<_DialogContent<T>> createState() => _DialogContentState<T>();
}

class _DialogContentState<T extends IDetailItem> extends State<_DialogContent<T>> {
  final bodyScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return getListeners(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 13,right: 4,left: 4),
                child: getHeader(context)
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: widget.controller,
                child: Column(
                  children: [
                    getCheckList(context),
                    const Divider(),
                    getContent(context),
                  ],
                )
              ),
            ),
            getButtons(context)
          ],
        ),
      ),
    );
  }

  Widget getContent(BuildContext context){
    final bloc = context.read<AddReadyCounterBloc>();
    return BlocBuilder<AddReadyCounterBloc, AddReadyCounterState>(
      builder: (context, state) {
        if(state.isLoading){
          return const SharedLoadingIndicator();
        }
        final items = state.items;
        return ListView.builder(
          shrinkWrap: true,
          controller: bodyScrollController,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return AddCounterItem(
              key: Key(item.id.toString()),
              item: item,
              showDetails: state.showDetails,
              selected: state.selectedItem == item,
              onClick: (){
                bloc.add(AddReadyCounterEventSelectItem(prayer: item));
              }
            );
          },
        );
      }
    );
  }

  Widget getCheckList(BuildContext context){
    final bloc = context.read<AddReadyCounterBloc>();
    return BlocSelector<AddReadyCounterBloc, AddReadyCounterState,bool>(
      selector: (state) => state.showDetails,
      builder: (context, showDetails){
        return CheckboxListTile(
          value: showDetails,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13)
          ),
          title: const Text("Detaylı Göster"),
          onChanged: (changedValue){
            bloc.add(AddReadyCounterEventShowDetails(showDetails: changedValue ?? false));
          }
        );
      }
    );
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          widget.title ?? "Zikir Seç",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)
          ),
        )
      ],
    );
  }

  Widget getButtons(BuildContext context){
    final bloc = context.read<AddReadyCounterBloc>();
    return BlocSelector<AddReadyCounterBloc, AddReadyCounterState,PrayerDhikr?>(
      selector: (state) => state.selectedItem,
      builder: (context, selectedItem){
        return SharedDiaButtons(
          onApprove: selectedItem == null ? null : (){
            bloc.add(AddReadyCounterEventAddCounter(prayer: selectedItem));
          },
          approveLabel: "Kaydet",
          onCancel: widget.onCancel,
        );
      },
    );
  }

  Widget getListeners({
    required Widget child,
    required BuildContext context
  }){
    final bloc = context.read<AddReadyCounterBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AddReadyCounterBloc,AddReadyCounterState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context, state){
            final message = state.message;
            if(message!=null){
              ToastUtils.showLongToast(message);
              bloc.add(AddReadyCounterEventClearMessage());
            }
          },
        ),
        BlocListener<AddReadyCounterBloc,AddReadyCounterState>(
          listenWhen: (prevState, nextState){
            return prevState.navigateBack != nextState.navigateBack;
          },
          listener: (context, state){
            final navigateBack = state.navigateBack;
            if(navigateBack){
              bloc.add(AddReadyCounterEventClearNavigateBack());
              Navigator.pop(context);
            }
          },
        )
      ],
      child: child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    bodyScrollController.dispose();
  }
}

