import 'package:sqflite/sqflite.dart';

import '../../features/hizb/data/data_sources/hizb_local_data_source_impl.dart';
import '../../features/hizb/data/repositories/hizb_repository_impl.dart';
import '../../features/hizb/domain/repositories/hizb_repository.dart';
import '../../features/juz/data/data_sources/juz_local_data_source_impl.dart';
import '../../features/juz/data/repositories/juz_repository_impl.dart';
import '../../features/juz/domain/repositories/juz_repository.dart';
import '../../features/surah/data/data_sources/surah_local_data_source_impl.dart';
import '../../features/surah/data/repositories/surah_name_repository_impl.dart';
import '../../features/surah/domain/repositories/surah_name_repository.dart';

class AppDependencies {
  final SurahNameRepository surahNameRepository;
  final JuzRepository juzRepository;
  final HizbRepository hizbRepository;

  const AppDependencies._({
    required this.surahNameRepository,
    required this.juzRepository,
    required this.hizbRepository,
  });

  factory AppDependencies.build(Database db) {
    final surahDataSource = SurahLocalDataSourceImpl(db);
    final surahRepository = SurahNameRepositoryImpl(surahDataSource);

    final juzDataSource = JuzLocalDataSourceImpl(db);
    final juzRepository = JuzRepositoryImpl(juzDataSource);

    final hizbDataSource = HizbLocalDataSourceImpl(db);
    final hizbRepository = HizbRepositoryImpl(hizbDataSource);

    return AppDependencies._(
      surahNameRepository: surahRepository,
      juzRepository: juzRepository,
      hizbRepository: hizbRepository,
    );
  }
}