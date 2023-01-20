
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/paging/default_paging_loader.dart';
import 'package:hadith/features/paging/i_paging_loader.dart';
import 'package:hadith/models/save_point_argument.dart';

class PagingArgument{
  final String title;
  final OriginTag originTag;
  final SavePointLoadArg savePointArg;
  final BookScopeEnum bookScope;
  final String? searchKey;
  late final IPagingLoader loader;

  PagingArgument({this.title="Liste",IPagingLoader? loader,
    required this.savePointArg,
    required this.originTag,
    required this.bookScope,this.searchKey}){
    this.loader=loader??DefaultPagingLoader();
  }
}