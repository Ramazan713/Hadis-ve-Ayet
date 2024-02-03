import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/auth/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hadith/core/features/auth/presentation/bloc/auth_event.dart';
import 'package:hadith/core/features/auth/presentation/bloc/auth_state.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/settings/presentation/components/user_info_icon.dart';
import '../settings_page.dart';
import 'package:settings_ui/settings_ui.dart';

extension SettingsPageAuthExt on SettingsPage{

  CustomSettingsSection getSignOutSection(BuildContext context){
    return CustomSettingsSection(
      child: CustomSettingsTile(
        child: _getSignOut(context),
      ),
    );
  }

  Widget getUserProfile(BuildContext context){
    return Column(
      children: [
        const SizedBox(
          height: 19,
        ),
        const CurrentUserIcon(),
        _getSignIn(context),
        _getUserInfo(context)
      ],
    );
  }


  Widget _getUserInfo(BuildContext context){
    return BlocSelector<AuthBloc, AuthState, AuthUser?>(
      selector: (state) => state.currentUser,
      builder: (context, user) {
        return CustomAnimatedVisibility(
          visible: user != null,
          child: Column(
            children: [
              const SizedBox(height: 4),
              Text(
                user?.displayName ?? "Boş",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? "Boş",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8)
            ],
          ),
        );
      }
    );
  }

  Widget _getSignIn(BuildContext context){
    final authBloc = context.read<AuthBloc>();
    return BlocSelector<AuthBloc, AuthState, AuthUser?>(
      selector: (state) => state.currentUser,
      builder: (context, user) {
        return CustomAnimatedVisibility(
          visible: user == null,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: FilledButton(
              onPressed: (){
                authBloc.add(AuthEventSignIn());
              },
              child: const Text("Giriş Yap"),
            ),
          ),
        );
      },
    );
  }


  Widget _getSignOut(BuildContext context){
    final authBloc = context.read<AuthBloc>();
    return BlocSelector<AuthBloc, AuthState, AuthUser?>(
      selector: (state) => state.currentUser,
      builder: (context, user) {
        return CustomAnimatedVisibility(
          visible: user != null,
          child: SettingsTile(
            title: Center(
              child: Text(
                "Çıkış Yap",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error
                ),
              )
            ),
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
      }
    );
  }
}