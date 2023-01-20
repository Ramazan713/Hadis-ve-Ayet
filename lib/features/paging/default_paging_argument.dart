

import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/paging/paging_argument.dart';
import 'package:hadith/models/save_point_argument.dart';

import 'default_paging_loader.dart';

class DefaultPagingArgument extends PagingArgument{
  DefaultPagingArgument() : super(
    savePointArg: SavePointLoadArg(parentKey: "0"),
    originTag: OriginTag.all,
    bookScope: BookScopeEnum.serlevha,
    title: "Liste",
    loader: DefaultPagingLoader(),
  );
}