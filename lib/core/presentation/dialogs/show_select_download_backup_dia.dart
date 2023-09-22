
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_event.dart';
import 'package:hadith/core/features/backup/backup_meta/bloc/backup_meta_bloc.dart';
import 'package:hadith/core/features/backup/backup_meta/bloc/backup_meta_event.dart';
import 'package:hadith/core/features/backup/backup_meta/bloc/backup_meta_state.dart';
import 'package:hadith/core/features/backup/components/backup_meta_item.dart';
import 'package:hadith/core/presentation/components/icon_text_item.dart';
import 'package:hadith/core/presentation/components/shared_empty_result.dart';
import 'package:hadith/core/presentation/components/shared_loading_indicator.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/core/utils/toast_utils.dart';

void showDownloadBackupDia(BuildContext context) {

  context.read<BackupMetaBloc>().add(BackupMetaEventLoadData());

  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) {
      return const Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 7),
        child: _DialogContent(),
      );
    });
}

class _DialogContent extends StatelessWidget {
   const _DialogContent({super.key});

  @override
  Widget build(BuildContext context) {

    return getListeners(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getHeader(context),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    getRefreshContent(context),
                    const SizedBox(height: 8),
                    getListItemsContent(context),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
            getButtons(context)
          ],
        ),
      ),
    );
  }

   Widget getHeader(BuildContext context){
     return Stack(
       alignment: Alignment.center,
       children: [
         const IconTextItem(
           iconData: Icons.cloud_download,
           title: "Buluttan İndir",
           margins: EdgeInsets.symmetric(horizontal: 48),
         ),
         Align(
           alignment: Alignment.centerRight,
           child: IconButton(
             onPressed: (){
               Navigator.pop(context);
             },
             icon: const Icon(Icons.close),
           ),
         )
       ],
     );
   }

   Widget getListeners({required Widget child}){
    return BlocListener<BackupMetaBloc,BackupMetaState>(
        listener: (context,state){
        final message = state.message;
        if(message!=null){
          context.read<BackupMetaBloc>().add(BackupMetaEventClearMessage());
          ToastUtils.showLongToast(message);
        }
      },
      child: child,
    );
   }

   Widget getRefreshContent(BuildContext context){
    final backupMetaBloc = context.read<BackupMetaBloc>();
    return Row(
      children: [
        BlocSelector<BackupMetaBloc,BackupMetaState,bool>(
          selector: (state)=>state.isRefreshDisabled,
          builder: (context,isDisableRefresh){
            return TextButton.icon(
              onPressed: isDisableRefresh == true ? null : () async {
                backupMetaBloc.add(BackupMetaEventRefresh());
              },
              icon: const Icon(
                Icons.refresh
              ),
              label: const Text("Yenile"),
            );
          }
        ),
        BlocSelector<BackupMetaBloc,BackupMetaState,String?>(
            selector: (state)=>state.counter,
            builder: (context,counter){
              return Text("$counter",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error
                ),
              );
            }
        ),
      ],
    );
   }

   Widget getListItemsContent(BuildContext context){
     final backupMetaBloc = context.read<BackupMetaBloc>();
     return BlocBuilder<BackupMetaBloc, BackupMetaState>(
      buildWhen: (prevState,nextState){
        return (prevState.items!=nextState.items) ||
            (prevState.isLoading!=nextState.isLoading) ||
            (prevState.selectedItem!=nextState.selectedItem);
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const SharedLoadingIndicator();
        }

        final items = state.items;
        if (items.isEmpty) {
          return const SharedEmptyResult(
            content: "Herhangi bir veri bulunamadı",
          );
        }

        return ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          controller: ScrollController(),
          itemBuilder: (context, index) {
            final item = items[index];
            return BackupMetaItem(
              item: item,
              isSelected: item == state.selectedItem,
              onTap: (){
                backupMetaBloc.add(BackupMetaEventSelectBackupMeta(backupMeta: item));
              },
            );
          },
        );
      }
     );
   }

   Widget getButtons(BuildContext context){
     final backupBloc = context.read<BackupBloc>();

     return Row(
      children: [
        Expanded(
          child: BlocSelector<BackupMetaBloc,BackupMetaState,BackupMetaModel?>(
            selector: (state)=>state.selectedItem,
            builder: (context,selectedBackup){
              return FilledButton(
                onPressed: selectedBackup == null ? null : (){
                  showCustomAlertDia(context,
                    title: "Devam etmek istiyor musunuz? (Üzerine Ekle)",
                    content: """Yerelde bulunan verileriniz silinmeyecektir ama üzerine ekleneceği için veri değişikliğine, gereksiz veri fazlalığına veya veri kaybına neden olabilir""",
                    btnApproved: () async {
                      backupBloc.add(BackupEventDownloadFile(
                          fileName: selectedBackup.fileName,
                          deleteAllLocalData: false
                      ));
                    });
                },
                child: const Text("Üzerine Ekle"),
              );
            }),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: BlocSelector<BackupMetaBloc,BackupMetaState,BackupMetaModel?>(
            selector: (state)=>state.selectedItem,
            builder: (context, selectedBackup){
              return FilledButton(
                onPressed: selectedBackup == null ? null : (){
                  showCustomAlertDia(context,
                      title: "Devam etmek istiyor musunuz? (Üzerine Yaz)",
                      content: """Yerelde bulunan verileriniz silinip buluttaki verileriniz yüklenecektir.(Yerelde kaydedilmemiş verileriniz varsa veri kaybına neden olabilir)""",
                      btnApproved: () async {
                        backupBloc.add(BackupEventDownloadFile(
                            fileName: selectedBackup.fileName,
                            deleteAllLocalData: true
                        ));
                      });
                },
                child: const Text("Üzerine Yaz"),
              );
            }),
        ),
      ],
    );
   }
}
