import 'package:sqflite/sqflite.dart';

import '../../features/surah/data/data_sources/surah_local_data_source_impl.dart';
import '../../features/surah/data/repositories/surah_name_repository_impl.dart';
import '../../features/surah/domain/repositories/surah_name_repository.dart';

class AppDependencies {
  final SurahNameRepository surahNameRepository;

  const AppDependencies._({
    required this.surahNameRepository,
  });

  factory AppDependencies.build(Database db) {
    final surahDataSource = SurahLocalDataSourceImpl(db);
    final surahRepository = SurahNameRepositoryImpl(surahDataSource);

    return AppDependencies._(
      surahNameRepository: surahRepository,
    );
  }
}