

import 'package:hadith/models/progress.dart';

class StreamResource<T>{
  StreamResource._();

  factory StreamResource.successItem(T data)=>StreamResourceSuccessItem<T>(data);

  factory StreamResource.successFinished()=>StreamResourceSuccessFinish<T>();

  factory StreamResource.error(String error)=>StreamResourceError<T>(error);

  factory StreamResource.loading({required Progress progress})=>
      StreamResourceLoading<T>(progress:progress);

  factory StreamResource.loadingWithData({required int downloaded,required int total,required T data})=>
      StreamResourceLoadingWithData<T>(data: data,total: total,downloaded: downloaded);

  factory StreamResource.next()=>StreamResourceNext();

  factory StreamResource.pause({Progress? progress})=>StreamResourcePause(progress: progress);
}


class StreamResourceNext<T> extends StreamResource<T>{
  StreamResourceNext():super._();
}

class StreamResourceSuccessItem<T> extends StreamResource<T>{
  final T data;
  StreamResourceSuccessItem(this.data) : super._();
}

class StreamResourceSuccessFinish<T> extends StreamResource<T>{
  StreamResourceSuccessFinish() : super._();
}

class StreamResourceError<T> extends StreamResource<T>{
  final String error;
  StreamResourceError(this.error):super._();
}

class StreamResourceLoading<T> extends StreamResource<T>{
  final Progress progress;
  StreamResourceLoading({required this.progress}):super._();
}

class StreamResourceLoadingWithData<T> extends StreamResource<T>{
  final int downloaded;
  final int total;
  final T data;
  StreamResourceLoadingWithData({required this.downloaded,required this.total, required this.data}):super._();
}

class StreamResourcePause<T> extends StreamResource<T>{
  final Progress? progress;
  StreamResourcePause({this.progress}):super._();
}