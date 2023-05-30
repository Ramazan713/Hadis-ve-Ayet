
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';

import '../../domain/constants/hadith_book_enum.dart';

class HadithAllPagingRepo extends HadithPaginationRepo{

  HadithBookEnum _hadithBookEnum = HadithBookEnum.serlevha;

  HadithAllPagingRepo({ required super.hadithRepo,
    required super.topicRepo, required super.itemListInfoRepo});

  HadithAllPagingRepo init(HadithBookEnum hadithBookEnum){
    _hadithBookEnum = hadithBookEnum;
    return this;
  }

  @override
  Future<List<Hadith>> getHadithItems(int pageSize, int startIndex) async{
    return hadithRepo.getPagingHadithsByBookId(_hadithBookEnum.bookId, pageSize, startIndex);
  }

  @override
  Future<int> getTotalItems() async{
    return (await hadithRepo.getHadithCountByBookId(_hadithBookEnum.bookId)) ?? 0;
  }

}