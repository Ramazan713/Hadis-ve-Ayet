

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/features/auth/bloc/auth_bloc.dart';
import 'package:hadith/core/features/auth/bloc/auth_event.dart';
import 'package:hadith/core/features/auth/bloc/auth_state.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/settings_/presentation/components/user_info_icon.dart';
import 'package:hadith/features/settings_/presentation/settings_page.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';
import 'package:settings_ui/settings_ui.dart';

extension SettingsPageAuthExt on SettingsPage{

  CustomSettingsSection getSignOutSection(){
    return const CustomSettingsSection(
      child: CustomSettingsTile(
        child: _SignOut(),
      ),
    );
  }

  Widget getUserProfile(){
    return const Column(
      children: [
        SizedBox(
          height: 19,
        ),
        CurrentUserIcon(),
        SizedBox(
          height: 7,
        ),
        _SignIn(),
        _UserInfo()
      ],
    );
  }


}


class _UserInfo extends StatelessWidget {
  const _UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, AuthUser?>(
        selector: (state) => state.currentUser,
        builder: (context, user) {
          return Visibility(
            visible: user != null,
            child: Column(
              children: [
                Text(user?.displayName ?? "Boş"),
                const SizedBox(
                  height: 7,
                ),
                Text(user?.email ?? "Boş"),
                const SizedBox(
                  height: 13,
                )
              ],
            ),
          );
        });
  }
}

class _SignIn extends StatelessWidget {
  const _SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return BlocSelector<AuthBloc, AuthState, AuthUser?>(
      selector: (state) => state.currentUser,
      builder: (context, user) {
        return Visibility(
            visible: (user == null),
            child: CustomButtonPositive(
              onTap: () async {
                authBloc.add(AuthEventSignIn());
              },
              label: "Giriş Yap",
            ));
      },
    );
  }
}

class _SignOut extends StatelessWidget {
  const _SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return BlocSelector<AuthBloc, AuthState, AuthUser?>(
        selector: (state) => state.currentUser,
        builder: (context, user) {
          return Visibility(
            visible: user != null,
            child: SettingsTile(
              title: const Center(
                  child: Text(
                    "Çıkış Yap",
                    style: TextStyle(color: Colors.redAccent),
                  )),
              onPressed: (context) {
                showCustomAlertDia(context,
                    title: "Çıkış yapmak istediğinize emin misiniz?",
                    btnApproved: () async {
                      showCustomAlertDia(context,
                          cancelLabel: "Devam Et",
                          approveLabel: "Oluştur",
                          title: "Yedekleme yapmak ister misiniz?",
                          content: "Kaydedilmeyen verileriniz kaybolabilir",
                          btnApproved: () async {
                            authBloc.add(AuthEventSignOutWithBackup());
                          }, btnCancelled: () async {
                            authBloc.add(AuthEventSignOut());
                          });
                    });
              },
            ),
          );
        });
  }
}