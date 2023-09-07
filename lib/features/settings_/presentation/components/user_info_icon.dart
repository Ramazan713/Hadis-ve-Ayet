
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';
import 'package:hadith/features/settings_/domain/models/user_info_model.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_state.dart';


class CurrentUserIcon extends StatelessWidget {
  const CurrentUserIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc,SettingsState,UserInfoModel?>(
      selector: (state)=>state.currentUserInfo,
      builder: (context, currentUserInfo) {
        return CustomAnimatedSwitcher(
          firstChild: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 73,
            child: CircleAvatar(
              backgroundImage: MemoryImage(currentUserInfo?.img ?? Uint8List(10),scale: 1),
              radius: 71,
            ),
          ),
          secondChild: const Icon(Icons.account_circle, size: 190,),
          showFirstChild: currentUserInfo!=null&&currentUserInfo.img!=null
        );
      }
    );
  }
}
