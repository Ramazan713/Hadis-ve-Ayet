


import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_result/select_quran_section_result.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';

abstract class IShowCustomPrayersEvent{}

class ShowCustomPrayersEventClearMessage extends IShowCustomPrayersEvent{}

class ShowCustomPrayersEventListenData extends IShowCustomPrayersEvent{}

class ShowCustomPrayersEventLoadData extends IShowCustomPrayersEvent{}

class ShowCustomPrayersEventSetQuery extends IShowCustomPrayersEvent{
  final String query;
  ShowCustomPrayersEventSetQuery({required this.query});
}

class ShowCustomPrayersEventHandleImport extends IShowCustomPrayersEvent{
  final String filePath;
  ShowCustomPrayersEventHandleImport({required this.filePath});
}

class ShowCustomPrayersEventSetSearchBarVisibility extends IShowCustomPrayersEvent{
  final bool isVisible;
  ShowCustomPrayersEventSetSearchBarVisibility({required this.isVisible});
}

class ShowCustomPrayersEventAddFromDhikr extends IShowCustomPrayersEvent{
  final PrayerDhikr prayer;
  ShowCustomPrayersEventAddFromDhikr({required this.prayer});
}

class ShowCustomPrayersEventAddDhikr extends IShowCustomPrayersEvent{
  final PrayerCustom prayer;
  ShowCustomPrayersEventAddDhikr({required this.prayer});
}

class ShowCustomPrayersEventAddPrayerFromQuran extends IShowCustomPrayersEvent{
  final SelectQuranSectionResult data;
  ShowCustomPrayersEventAddPrayerFromQuran({required this.data});
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

