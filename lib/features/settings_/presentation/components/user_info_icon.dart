
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          if(currentUserInfo!=null&&currentUserInfo.img!=null){
            return CircleAvatar(
              backgroundColor: Colors.black,
              radius: 74,
              child: CircleAvatar(
                backgroundImage:MemoryImage(currentUserInfo.img!,scale: 1),
                radius: 71,
              ),
            );
          }
          return const Icon(Icons.account_circle, size: 190,);
        });
  }
}
