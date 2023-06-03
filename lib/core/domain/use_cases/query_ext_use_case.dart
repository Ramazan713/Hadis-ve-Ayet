

class QueryExtUseCase{


  QueryExtResult call(String query){
    final queryLikeForSearch = "%$query%".split(" ").join("%");
    final queryLikeForOrder = "$query%".split(" ").join("%");
    final queryRaw = query.toLowerCase();

    return QueryExtResult(
      queryRaw: queryRaw,
      queryLikeForOrder: queryLikeForOrder,
      queryLikeForSearch: queryLikeForSearch
    );
  }

}

class QueryExtResult{
  final String queryRaw;
  final String queryLikeForSearch;
  final String queryLikeForOrder;

  QueryExtResult({
    required this.queryRaw, required this.queryLikeForSearch,
    required this.queryLikeForOrder
  });
}