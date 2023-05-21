

class PagingConfig{
  final int pageSize;
  final int currentPos;
  final int preFetchDistance;

  PagingConfig({required this.pageSize,this.currentPos = 1,this.preFetchDistance = 3});
}