
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/model/id_model.dart';

abstract class AttachNotificationIdService{

  static const int defaultNotificationId = 777;

  AttachNotificationIdService.empty({required int size});
  AttachNotificationIdService();

  AttachNotificationIdService setModels({required List<IdModel> models});

  Future<void> attachId(AudioServiceEnum serviceEnum);

  Future<void> detachId(AudioServiceEnum serviceEnum);
}



