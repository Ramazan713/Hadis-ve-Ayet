
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/presentation/components/shared_dia_buttons.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/handlers/bottom_sheet_handler.dart';
import 'package:hadith/features/dhikr_prayers/shared/presentation/select_dhikr/bloc/select_dhikr_bloc.dart';
import 'package:hadith/features/dhikr_prayers/shared/presentation/select_dhikr/bloc/select_dhikr_event.dart';
import 'package:hadith/features/dhikr_prayers/shared/presentation/select_dhikr/bloc/select_dhikr_state.dart';
import 'package:hadith/features/dhikr_prayers/shared/presentation/select_dhikr/components/select_dhikr_item.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';
import 'package:hadith/core/utils/toast_utils.dart';

void showSelectDhikrDia<T extends IDetailItem>(
    BuildContext context,{
      required void Function(PrayerDhikr selectedDhikr) onSelected
}){

  context.read<SelectDhikrCounterBloc>().add(SelectDhikrEventLoadData());

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
            onSelected: onSelected,
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
  final void Function(PrayerDhikr selectedDhikr) onSelected;

  const _DialogContent({
    Key? key,
    this.title,
    required this.onCancel,
    required this.controller,
    required this.onSelected
  }) : super(key: key);

  @override
  State<_DialogContent<T>> createState() => _DialogContentState<T>();
}

class _DialogContentState<T extends IDetailItem> extends State<_DialogContent<T>> {
  final bodyScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }

  Widget getContent(BuildContext context){
    final bloc = context.read<SelectDhikrCounterBloc>();
    return BlocBuilder<SelectDhikrCounterBloc, SelectDhikrState>(
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
            return SelectDhikrItem(
              key: Key(item.id.toString()),
              item: item,
              showDetails: state.showDetails,
              selected: state.selectedItem == item,
              onClick: (){
                bloc.add(SelectDhikrEventSelectItem(prayer: item));
              }
            );
          },
        );
      }
    );
  }

  Widget getCheckList(BuildContext context){
    final bloc = context.read<SelectDhikrCounterBloc>();
    return BlocSelector<SelectDhikrCounterBloc, SelectDhikrState,bool>(
      selector: (state) => state.showDetails,
      builder: (context, showDetails){
        return CheckboxListTile(
          value: showDetails,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13)
          ),
          title: const Text("Detaylı Göster"),
          onChanged: (changedValue){
            bloc.add(SelectDhikrEventShowDetails(showDetails: changedValue ?? false));
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
    return BlocSelector<SelectDhikrCounterBloc, SelectDhikrState,PrayerDhikr?>(
      selector: (state) => state.selectedItem,
      builder: (context, selectedItem){
        return SharedDiaButtons(
          onApprove: selectedItem == null ? null : (){
            widget.onSelected(selectedItem);
            Navigator.pop(context);
          },
          approveLabel: "Kaydet",
          onCancel: widget.onCancel,
        );
      },
    );
  }

  @override
  void dispose() {
    bodyScrollController.dispose();
    super.dispose();
  }
}

