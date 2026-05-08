// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class FavoriteAyahItem extends StatelessWidget {
//   const FavoriteAyahItem({
//     super.key,
//     required this.ayahByAyahModel,
//     required this.index,
//   });
//
//   final AyahByAyahEntity ayahByAyahModel;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     final appColors = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: () {},
//       onLongPress: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (ctx) {
//             return const SizedBox.shrink();
//           },
//         );
//       },
//       child: Container(
//         padding: AppStyles.mainPadding,
//         decoration: const BoxDecoration(
//           border: Border.symmetric(
//             horizontal: BorderSide(
//               width: 0.25,
//               color: Colors.grey,
//             ),
//           ),
//         ),
//         child: Consumer<ReadingSettingsState>(
//           builder: (context, readingSettingsState, _) {
//             return Column(
//               crossAxisAlignment: .stretch,
//               children: [
//                 Text(
//                   ayahByAyahModel.ayahArabic,
//                   textDirection: TextDirection.rtl,
//                   style: TextStyle(
//                     fontSize: readingSettingsState.ayahArabicTextSize,
//                     fontFamily: AppStrings.fontUthmanicHafs,
//                     height: 2.5,
//                     letterSpacing: 0,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 Text(
//                   ayahByAyahModel.ayahTranslation,
//                   style: TextStyle(
//                     fontSize: readingSettingsState.ayahTranslationTextSize,
//                     fontFamily: AppStrings.fontGilroy,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 Text(
//                   surahInfo,
//                   style: AppStyles.mainTextStyle16.copyWith(
//                     color: appColors.onSurface.withAlpha(105),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
