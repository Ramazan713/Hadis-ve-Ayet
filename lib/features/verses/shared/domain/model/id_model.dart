

import 'package:equatable/equatable.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/notification/notification_base.dart';

class IdModel extends Equatable{
  final AudioServiceEnum serviceEnum;
  final NotificationBase notificationBase;

  const IdModel({required this.notificationBase, required this.serviceEnum});

  @override
  List<Object?> get props => [serviceEnum];
}
