import 'package:hadith/core/data/local/entities/esmaul_husna_entity.dart';
import 'package:hadith/core/features/backup/data/remote/dtos/esmaul_husna_info_dto/esmaul_husna_info_dto.dart';

extension EsmaulHusnaEntityBackupExt on EsmaulHusnaEntity{
  EsmaulHusnaInfoDto toEsmaulHusnaInfoDto(){
    return EsmaulHusnaInfoDto(
      orderItem: orderItem,
      counterId: counterId
    );
  }
}
