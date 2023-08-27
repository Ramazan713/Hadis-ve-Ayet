
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/db/entities/user_info_entity.dart';
import 'package:hadith/features/settings/bloc/setting_bloc.dart';
import 'package:hadith/features/settings/bloc/setting_state.dart';


class CurrentUserIcon extends StatelessWidget {
  const CurrentUserIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingBloc,SettingState,UserInfoEntityOld?>(
        selector: (state)=>state.userInfoEntity,
        builder: (context, userInfoEntity) {
          if(userInfoEntity!=null&&userInfoEntity.img!=null){
            return CircleAvatar(
              backgroundColor: Colors.black,
              radius: 74,
              child: CircleAvatar(
                backgroundImage:MemoryImage(userInfoEntity.img!,scale: 1),
                radius: 71,
              ),
            );
          }
          return const Icon(Icons.account_circle, size: 190,);
        });
  }
}
