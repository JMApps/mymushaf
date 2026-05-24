import 'package:sqflite/sqflite.dart';

import '../../features/ayahs/data/data_sources/ayah_by_ayah_data_source_impl.dart';
import '../../features/ayahs/data/repositories/ayah_by_ayah_repository_impl.dart';
import '../../features/ayahs/domain/repositories/ayah_by_ayah_repository.dart';
import '../../features/hizb/data/data_sources/hizb_local_data_source_impl.dart';
import '../../features/hizb/data/repositories/hizb_repository_impl.dart';
import '../../features/hizb/domain/repositories/hizb_repository.dart';
import '../../features/juz/data/data_sources/juz_local_data_source_impl.dart';
import '../../features/juz/data/repositories/juz_repository_impl.dart';
import '../../features/juz/domain/repositories/juz_repository.dart';
import '../../features/main/data/data_sources/page_meta_data_source_impl.dart';
import '../../features/main/data/repositories/page_meta_repository_impl.dart';
import '../../features/main/domain/repositories/page_meta_repository.dart';
import '../../features/reader/data/data_source/mushaf_page_data_source_impl.dart';
import '../../features/reader/data/repositories/mushaf_page_repository_impl.dart';
import '../../features/reader/domain/repositories/mushaf_page_repository.dart';
import '../../features/surah/data/data_sources/surah_local_data_source_impl.dart';
import '../../features/surah/data/repositories/surah_name_repository_impl.dart';
import '../../features/surah/domain/repositories/surah_name_repository.dart';

class AppDependencies {
  final PageMetaRepository pageMetaRepository;
  final SurahNameRepository surahNameRepository;
  final JuzRepository juzRepository;
  final HizbRepository hizbRepository;
  final AyahByAyahRepository ayahByAyahRepository;
  final MushafPageRepository mushafPageRepository;

  const AppDependencies._({
    required this.pageMetaRepository,
    required this.surahNameRepository,
    required this.juzRepository,
    required this.hizbRepository,
    required this.ayahByAyahRepository,
    required this.mushafPageRepository,
  });

  factory AppDependencies.build(Database db) {
    final pageMetaDataSource = PageMetaDataSourceImpl(db);
    final pageMetaRepository = PageMetaRepositoryImpl(pageMetaDataSource);

    final surahDataSource = SurahLocalDataSourceImpl(db);
    final surahRepository = SurahNameRepositoryImpl(surahDataSource);

    final juzDataSource = JuzLocalDataSourceImpl(db);
    final juzRepository = JuzRepositoryImpl(juzDataSource);

    final hizbDataSource = HizbLocalDataSourceImpl(db);
    final hizbRepository = HizbRepositoryImpl(hizbDataSource);

    final ayahByAyahLocalDataSource = AyahByAyahDataSourceImpl(db);
    final ayahByAyahRepository = AyahByAyahRepositoryImpl(ayahByAyahLocalDataSource);

    final mushafPageLocalDataSource = MushafPageDataSourceImpl(db);
    final mushafPageRepository = MushafPageRepositoryImpl(mushafPageLocalDataSource);

    return AppDependencies._(
      pageMetaRepository: pageMetaRepository,
      surahNameRepository: surahRepository,
      juzRepository: juzRepository,
      hizbRepository: hizbRepository,
      ayahByAyahRepository: ayahByAyahRepository,
      mushafPageRepository: mushafPageRepository,
    );
  }
}
