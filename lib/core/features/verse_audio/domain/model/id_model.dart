

import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_service_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/notification_base.dart';

class IdModel extends Equatable{
  final AudioServiceEnum serviceEnum;
  final NotificationBase notificationBase;

  const IdModel({required this.notificationBase, required this.serviceEnum});

  @override
  List<Object?> get props => [serviceEnum];
}
