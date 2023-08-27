import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/backup/components/backup_meta_item.dart';
import 'package:hadith/features/backup/components/icon_text_item.dart';
import 'package:hadith/features/settings/auth_bloc/auth_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_event.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/buttons/custom_button_negative.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:hadith/constants/enums/data_status_enum.dart';
import 'package:hadith/db/entities/backup_meta.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_event.dart';
import 'package:hadith/features/backup/backup_meta/bloc/backup_meta_state.dart';
import 'backup_meta/bloc/backup_meta_bloc.dart';

void showDownloadBackupDia(BuildContext context) {

  final backupMetaBloc = context.read<BackupMetaBlocOld>();

  final ScrollController _scrollController=ScrollController();

  showDialog(
      context: context,
      builder: (context) {
        final bodyText1Style = Theme.of(context).textTheme.bodyText1;

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 7),
          child: SingleChildScrollView(
            controller: _scrollController,
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
                  BlocBuilder<BackupMetaBlocOld, BackupMetaState>(
                      buildWhen: (prevState,nextState){
                        return (prevState.backupMetas!=nextState.backupMetas) ||
                            (prevState.status!=nextState.status) ||
                            (prevState.selectedBackup!=nextState.selectedBackup);
                      },
                      builder: (context, state) {
                    if (state.status == DataStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final items = state.backupMetas;

                    if (items.isEmpty) {
                      return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 23),
                          child: Text(
                            "Herhangi bir veri bulunamadı",
                            textAlign: TextAlign.center,
                          ));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return BackupMetaItem(
                            item: item,
                            isSelected: item == state.selectedBackup,
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
    final authBloc = context.read<AuthBlocOld>();
    final backupMetaBloc = context.read<BackupMetaBlocOld>();


    return BlocListener<BackupMetaBlocOld,BackupMetaState>(
      listener: (context,state){
        if(state.message!=null){
          ToastUtils.showLongToast(state.message??"");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocSelector<BackupMetaBlocOld,BackupMetaState,String?>(
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
          BlocSelector<BackupMetaBlocOld,BackupMetaState,bool>(
              selector: (state)=>state.isDisableRefresh,
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
    final authBloc = context.read<AuthBlocOld>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocSelector<BackupMetaBlocOld,BackupMetaState,BackupMetaOld?>(
            selector: (state)=>state.selectedBackup,
            builder: (context,selectedBackup){
              return CustomButtonPositive(onTap: () async {
                if (selectedBackup != null) {
                  showCustomAlertBottomDia(context,
                      title: "Devam etmek istiyor musunuz? (Üzerine Yaz)",
                      content:
                      """Yerelde bulunan verileriniz silinip buluttaki verileriniz yüklenecektir.(Yerelde kaydedilmemiş verileriniz varsa veri kaybına neden olabilir)""",
                      btnApproved: () async {
                        authBloc.add(AuthEventDownloadFile(fileName: selectedBackup.fileName,deleteAllLocalData: true));
                      });
                }
              },label: "Üzerine Yaz",);
            }),
        BlocSelector<BackupMetaBlocOld,BackupMetaState,BackupMetaOld?>(
            selector: (state)=>state.selectedBackup,
            builder: (context,selectedBackup){
              return CustomButtonPositive(onTap: () {
                if (selectedBackup != null) {
                  showCustomAlertBottomDia(context,
                      title: "Devam etmek istiyor musunuz? (Üzerine Ekle)",
                      content:
                      """Yerelde bulunan verileriniz silinmeyecektir ama üzerine ekleneceği için veri değişikliğine, gereksiz veri fazlalığına veya veri kaybına neden olabilir""",
                      btnApproved: () async {
                        authBloc.add(AuthEventDownloadFile(fileName: selectedBackup.fileName,deleteAllLocalData: false));
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
