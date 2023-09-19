

class PagingConfig{
  final int pageSize;
  final int currentPos;
  final int preFetchDistance;
  final int? currentPage;

  PagingConfig({
    required this.pageSize,
    this.currentPos = 1,
    this.preFetchDistance = 3,
    this.currentPage
  });
}