import 'package:sqflite/sqflite.dart';

import '../../features/juz/data/data_sources/juz_local_data_source_impl.dart';
import '../../features/juz/data/repositories/juz_repository_impl.dart';
import '../../features/juz/domain/repositories/juz_repository.dart';
import '../../features/surah/data/data_sources/surah_local_data_source_impl.dart';
import '../../features/surah/data/repositories/surah_name_repository_impl.dart';
import '../../features/surah/domain/repositories/surah_name_repository.dart';

class AppDependencies {
  final SurahNameRepository surahNameRepository;
  final JuzRepository juzRepository;

  const AppDependencies._({
    required this.surahNameRepository,
    required this.juzRepository,
  });

  factory AppDependencies.build(Database db) {
    final surahDataSource = SurahLocalDataSourceImpl(db);
    final surahRepository = SurahNameRepositoryImpl(surahDataSource);

    final juzDataSource = JuzLocalDataSourceImpl(db);
    final juzRepository = JuzRepositoryImpl(juzDataSource);

    return AppDependencies._(
      surahNameRepository: surahRepository,
      juzRepository: juzRepository,
    );
  }
}