// import 'package:flutter/material.dart';
//
//
// class HadithSharedHeader extends StatelessWidget {
//
//   final Widget child;
//
//   const HadithSharedHeader({Key? key,required this.child}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomNestedViewAppBar(
//       scrollController: controller,
//       floatHeaderSlivers: true,
//       title: Text("All Hadiths"),
//       actions: [
//         BlocBuilder<PaginationBloc, PaginationState>(
//           buildWhen: (prevState,nextState){
//             return prevState.visibleMinPos != nextState.visibleMinPos;
//           },
//           builder: (context,state){
//             return IconButton(onPressed: (){
//               try{
//                 final item = state.visibleMiddleItem.castOrNull<HadithListModel>();
//
//                 if(item is HadithListModel){
//                   showGetNumberBottomDia(context,(newPos){
//                     pagingBloc.add(PaginationEventJumpToPos(pos: newPos));
//                   },currentIndex: item.rowNumber,limitIndex: state.totalItems - 1);
//                 }
//               }catch (e){}
//
//             }, icon: const Icon(Icons.map));
//           },
//         ),
//         BlocSelector<PaginationBloc,PaginationState,HadithListModel?>(
//             selector: (state)=> state.visibleMiddleItem.castOrNull<HadithListModel>(),
//             builder: (context, visibleMiddleItem){
//               return CustomDropdownBarMenu(
//                   items: SharedHadithBarItem.values,
//                   selectedFunc: (menuItem){
//                     switch(menuItem){
//                       case SharedHadithBarItem.fontSize:
//                         showSelectFontSizeBottomDia(context);
//                         break;
//                       case SharedHadithBarItem.savePoint:
//                         showEditSavePointsDiaBasic(context,
//                             destination: DestinationAll(bookEnum: BookEnum.serlevha),
//                             itemIndexPos: visibleMiddleItem?.rowNumber ?? 0,
//                             onLoadSavePointClick: (savePoint){
//                               pagingBloc.add(PaginationEventJumpToPos(pos: savePoint.itemIndexPos));
//                             }
//                         );
//                         break;
//                     }
//                   }
//               );
//             }
//         )
//       ],
//       child: child,
//     );
//   }
// }
