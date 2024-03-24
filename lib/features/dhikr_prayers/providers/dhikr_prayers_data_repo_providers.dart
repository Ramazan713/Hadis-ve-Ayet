import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/data/local/database.dart';
import 'package:hadith/features/dhikr_prayers/counters/data/repo/counter_repo_impl.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/repo/counter_repo.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/manager/prayer_custom_share_manager_impl.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/repo/prayer_custom_repo_impl.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/repo/prayer_repo_impl.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/manager/prayer_custom_share_manager.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_repo.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';



List<RepositoryProvider> pDhikrAndPrayersDataRepoProviders(AppDatabase appDatabase){
  return [
    RepositoryProvider<PrayerRepo>(create: (context) => PrayerRepoImpl(
      prayerDao: appDatabase.prayerDao,
    )),
    RepositoryProvider<PrayerCustomRepo>(create: (context) => PrayerCustomRepoImpl(
        prayerDao: appDatabase.prayerDao,
        counterDao: appDatabase.counterDao,
        queryExtUseCase: context.read()
    )),
    RepositoryProvider<CounterRepo>(create: (context) => CounterRepoImpl(
        counterDao: appDatabase.counterDao
    )),
    RepositoryProvider<PrayerCustomShareManager>(create: (context) => PrayerCustomShareManagerImpl(
      prayerCustomRepo: context.read()
    )),
  ];
}