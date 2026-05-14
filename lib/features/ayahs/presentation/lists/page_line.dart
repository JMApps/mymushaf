import '../../domain/entities/ayah_by_ayah_entity.dart';

sealed class PageLine {
  const PageLine();
}

class SurahLine extends PageLine {
  final int surahNumber;

  const SurahLine(this.surahNumber);
}

class BasmallahLine extends PageLine {
  const BasmallahLine();
}

class AyahLine extends PageLine {
  final AyahByAyahEntity ayah;
  final int index;

  const AyahLine(this.ayah, this.index);
}