
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/backup_meta_model/backup_meta_model.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_event.dart';
import 'package:hadith/core/features/backup/backup_meta/bloc/backup_meta_bloc.dart';
import 'package:hadith/core/features/backup/backup_meta/bloc/backup_meta_event.dart';
import 'package:hadith/core/features/backup/backup_meta/bloc/backup_meta_state.dart';
import 'package:hadith/core/features/backup/components/backup_meta_item.dart';
import 'package:hadith/core/presentation/bottom_sheets/showCustomAlertBottomDia.dart';
import 'package:hadith/features/backup/components/icon_text_item.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showDownloadBackupDia(BuildContext context) {

  final backupMetaBloc = context.read<BackupMetaBloc>();

  final ScrollController scrollController = ScrollController();

  showDialog(
      context: context,
      builder: (context) {
        final bodyText1Style = Theme.of(context).textTheme.bodyText1;

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 7),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const IconTextItem(iconData: Icons.cloud_download,title: "Buluttan İndir"),
                  const _RefreshContent(),
                  const SizedBox(
                    height: 13,
                  ),
                  BlocBuilder<BackupMetaBloc, BackupMetaState>(
                      buildWhen: (prevState,nextState){
                        return (prevState.items!=nextState.items) ||
                            (prevState.isLoading!=nextState.isLoading) ||
                            (prevState.selectedItem!=nextState.selectedItem);
                      },
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final items = state.items;

                        if (items.isEmpty) {
                          return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 23),
                              child: Text(
                                "Herhangi bir veri bulunamadı",
                                textAlign: TextAlign.center,
                              ));
                        }

                        return ListView.builder(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return BackupMetaItem(
                                item: item,
                                isSelected: item == state.selectedItem,
                                textStyle: bodyText1Style,
                                onTap: (){
                                  backupMetaBloc.add(BackupMetaEventSelectBackupMeta(backupMeta: item));
                                },
                              );
                            },
                            itemCount: items.length,
                            shrinkWrap: true);
                      }),
                  const SizedBox(
                    height: 13,
                  ),
                  const _ContentButtons()
                ],
              ),
            ),
          ),
        );
      });
}


class _RefreshContent extends StatelessWidget {
  const _RefreshContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backupMetaBloc = context.read<BackupMetaBloc>();

    return BlocListener<BackupMetaBloc,BackupMetaState>(
      listener: (context,state){
        final message = state.message;
        if(message!=null){
          backupMetaBloc.add(BackupMetaEventClearMessage());
          ToastUtils.showLongToast(message);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocSelector<BackupMetaBloc,BackupMetaState,String?>(
              selector: (state)=>state.counter,
              builder: (context,counter){
                return Text(
                  "$counter",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).errorColor),
                );
              }
          ),
          const SizedBox(width: 7,),
          BlocSelector<BackupMetaBloc,BackupMetaState,bool>(
              selector: (state)=>state.isRefreshDisabled,
              builder: (context,isDisableRefresh){
                return IconButton(
                  onPressed: isDisableRefresh == true ? null : () async {
                    backupMetaBloc.add(BackupMetaEventRefresh());
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 30,
                  ),
                  tooltip: "Güncel olmadığını düşünüyorsanız tıklayın",
                );
              }
          ),
          const SizedBox(
            width: 3,
          ),
        ],
      ),
    );
  }
}

class _ContentButtons extends StatelessWidget {
  const _ContentButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backupBloc = context.read<BackupBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocSelector<BackupMetaBloc,BackupMetaState,BackupMetaModel?>(
            selector: (state)=>state.selectedItem,
            builder: (context,selectedBackup){
              return CustomButtonPositive(onTap: () async {
                if (selectedBackup != null) {
                  showCustomAlertBottomDia(context,
                      title: "Devam etmek istiyor musunuz? (Üzerine Yaz)",
                      content:
                      """Yerelde bulunan verileriniz silinip buluttaki verileriniz yüklenecektir.(Yerelde kaydedilmemiş verileriniz varsa veri kaybına neden olabilir)""",
                      btnApproved: () async {
                        backupBloc.add(BackupEventDownloadFile(
                            fileName: selectedBackup.fileName,
                            deleteAllLocalData: true
                        ));
                      });
                }
              },label: "Üzerine Yaz",);
            }),
        BlocSelector<BackupMetaBloc,BackupMetaState,BackupMetaModel?>(
            selector: (state)=>state.selectedItem,
            builder: (context,selectedBackup){
              return CustomButtonPositive(onTap: () {
                if (selectedBackup != null) {
                  showCustomAlertBottomDia(context,
                      title: "Devam etmek istiyor musunuz? (Üzerine Ekle)",
                      content:
                      """Yerelde bulunan verileriniz silinmeyecektir ama üzerine ekleneceği için veri değişikliğine, gereksiz veri fazlalığına veya veri kaybına neden olabilir""",
                      btnApproved: () async {
                        backupBloc.add(BackupEventDownloadFile(
                            fileName: selectedBackup.fileName,
                            deleteAllLocalData: false
                        ));
                      });
                }
              }, label: "Üzerine Ekle",);
            }),
        CustomButtonNegative(onTap: () {
          Navigator.pop(context);
        }),
      ],
    );
  }
}
