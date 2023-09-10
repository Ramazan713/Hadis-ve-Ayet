
sealed class StreamResource<T>{
  StreamResource._();
  factory StreamResource.successStep(T data)=>StreamResourceSuccessStep<T>(data);

  factory StreamResource.error(String error)=>StreamResourceError<T>(error);

  factory StreamResource.loadingWithData({required int progress,required int total,required T data})=>
      StreamResourceLoadingWithData<T>(data: data,total: total,progress: progress);
}


class StreamResourceSuccessStep<T> extends StreamResource<T>{
  final T data;
  StreamResourceSuccessStep(this.data) : super._();
}

class StreamResourceSuccessAll<T,Y> extends StreamResource<T>{
  final Y result;
  StreamResourceSuccessAll(this.result): super._();
}

class StreamResourceError<T> extends StreamResource<T>{
  final String error;
  StreamResourceError(this.error): super._();
}

class StreamResourceLoadingWithData<T> extends StreamResource<T>{
  final int progress;
  final int total;
  final T data;
  StreamResourceLoadingWithData({required this.progress,required this.total, required this.data}): super._();
}
