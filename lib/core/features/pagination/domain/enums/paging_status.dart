

enum PagingStatus{
  init,
  loading,
  success,
  prevLoading,
  nextLoading
}

extension PagingStatusExt on PagingStatus{

  bool get isLoading => this == PagingStatus.loading;
  bool get isPrevLoading => this == PagingStatus.prevLoading;
  bool get isNextLoading => this == PagingStatus.nextLoading;
  bool get isSuccess => this == PagingStatus.success;

  bool get isAnyLoading{
    return isLoading || isPrevLoading || isNextLoading;
  }
}
