
import 'package:hadith/core/features/verse_audio/domain/model/id_model.dart';

import '../enums/audio_service_enum.dart';

abstract class AttachNotificationIdService{

  static const int defaultNotificationId = 777;

  AttachNotificationIdService.empty({required int size});
  AttachNotificationIdService();

  AttachNotificationIdService setModels({required List<IdModel> models});

  Future<void> attachId(AudioServiceEnum serviceEnum);

  Future<void> detachId(AudioServiceEnum serviceEnum);
}



