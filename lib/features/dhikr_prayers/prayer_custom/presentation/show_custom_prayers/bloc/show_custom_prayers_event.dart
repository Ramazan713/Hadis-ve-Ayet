


import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';

abstract class IShowCustomPrayersEvent{}

class ShowCustomPrayersEventClearMessage extends IShowCustomPrayersEvent{}

class ShowCustomPrayersEventListenData extends IShowCustomPrayersEvent{}

class ShowCustomPrayersEventLoadData extends IShowCustomPrayersEvent{}

class ShowCustomPrayersEventSetQuery extends IShowCustomPrayersEvent{
  final String query;
  ShowCustomPrayersEventSetQuery({required this.query});
}

class ShowCustomPrayersEventSetSearchBarVisibility extends IShowCustomPrayersEvent{
  final bool isVisible;
  ShowCustomPrayersEventSetSearchBarVisibility({required this.isVisible});
}

class ShowCustomPrayersEventAddDhikr extends IShowCustomPrayersEvent{
  final PrayerCustom prayer;
  ShowCustomPrayersEventAddDhikr({required this.prayer});
}

class ShowCustomPrayersEventSetDetailView extends IShowCustomPrayersEvent{
  final bool showDetail;
  ShowCustomPrayersEventSetDetailView({required this.showDetail});
}


class ShowCustomPrayersEventUpdateDhikr extends IShowCustomPrayersEvent{
  final PrayerCustom prayer;
  ShowCustomPrayersEventUpdateDhikr({required this.prayer});
}

class ShowCustomPrayersEventDelete extends IShowCustomPrayersEvent{
  final PrayerCustom prayer;
  ShowCustomPrayersEventDelete({required this.prayer});
}

