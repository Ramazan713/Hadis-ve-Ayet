

abstract class ISettingsEvent{}

class SettingsEventListenAppPref extends ISettingsEvent{}

class SettingsEventListenUserInfo extends ISettingsEvent{}

class SettingsEventLoadData extends ISettingsEvent{}

class SettingsEventResetSettings extends ISettingsEvent{}


class SettingsEventSetArchiveAsList extends ISettingsEvent{
  final bool archiveAsList;
  SettingsEventSetArchiveAsList({required this.archiveAsList});
}

class SettingsEventSetShowListIcons extends ISettingsEvent{
  final bool showListIcons;
  SettingsEventSetShowListIcons({required this.showListIcons});
}

class SettingsEventRequestUserInfo extends ISettingsEvent{
  final String? userId;
  SettingsEventRequestUserInfo({required this.userId});
}


