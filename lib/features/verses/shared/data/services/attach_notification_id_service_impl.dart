

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/model/id_model.dart';
import 'package:hadith/features/verses/shared/domain/services/attach_notification_id_service.dart';
import 'package:mutex/mutex.dart';

class AttachNotificationIdServiceImpl extends AttachNotificationIdService{
  final Set<int> _baseIds = {};
  final Set<int> _usedIds = {};
  final Mutex _lock = Mutex();
  final Set<IdModel> _baseModels = {};
  final Set<IdModel> _usedModels = {};

  AttachNotificationIdServiceImpl();

  AttachNotificationIdServiceImpl.empty({required int size}) : super.empty(size: size){
    _generateIds(size);
  }

  @override
  AttachNotificationIdService setModels({required List<IdModel> models}){
    _generateIds(models.length);
    _baseModels.clear();
    _baseModels.addAll(models);
    return this;
  }

  @override
  Future<void> attachId(AudioServiceEnum serviceEnum) async{

    await _lock.acquire();

    final model = _baseModels.firstWhereOrNull((element) => element.serviceEnum == serviceEnum);

    if(!_usedIds.contains(AttachNotificationIdService.defaultNotificationId)){
      if(model!=null && !_usedModels.contains(model)){
        _attachModel(model,AttachNotificationIdService.defaultNotificationId);
      }
    }else{
      while(true){
        final num = _baseIds.firstOrNull;
        if(num == null) break;
        if(!_usedIds.contains(num)){
          if(model!=null && !_usedModels.contains(model)){
            _attachModel(model, num);
          }
        }else{
          break;
        }
      }
    }
    _lock.release();
  }

  @override
  Future<void> detachId(AudioServiceEnum serviceEnum)async{
    await _lock.acquire();

    final model = _baseModels.firstWhereOrNull((element) => element.serviceEnum == serviceEnum);

    if(model == null) return _lock.release();

    final id = model.notificationBase.notificationId;
    _usedModels.remove(model);
    _usedIds.remove(id);
    if(id == AttachNotificationIdService.defaultNotificationId){
      final otherModel = _usedModels.firstOrNull;
      if(otherModel!=null){
        await otherModel.notificationBase.dismiss();
        _usedIds.remove(otherModel.notificationBase.notificationId);
        _attachModel(otherModel, AttachNotificationIdService.defaultNotificationId);
        await otherModel.notificationBase.showDefaultNotification();
      }
    }else{
      await model.notificationBase.dismiss();
    }
    _lock.release();
  }

  void _generateIds(int size){
    while(true){
      final num = Random.secure().nextInt(size * 2) + 100;
      if(_baseIds.length < size){
        if(!_baseIds.contains(num)){
          _baseIds.add(num);
        }
      }else{
        break;
      }
    }
  }

  void _attachModel(IdModel model, int id){
    _usedIds.add(id);
    model.notificationBase.notificationId = id;
    _usedModels.add(model);
  }
}