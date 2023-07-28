
import 'package:equatable/equatable.dart';

class AudioInfoResultModel<T> extends Equatable{
  final T? downloadingItem;
  final T? listeningItem;
  final List<int> downloadingQueueItems;

  const AudioInfoResultModel({required this.downloadingItem, required this.listeningItem, required this.downloadingQueueItems});

  @override
  List<Object?> get props => [downloadingItem, listeningItem, downloadingQueueItems];
}