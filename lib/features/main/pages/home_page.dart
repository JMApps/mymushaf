import 'package:flutter/material.dart';
import 'package:mymushaf/features/surah/presentation/pages/surah_name_page.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/theme/app_paddings.dart';
import '../../../core/theme/app_shapes.dart';
import '../../../l10n/app_localizations.dart';
import '../states/main_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<Widget> _mainPages;

  @override
  void initState() {
    super.initState();
    _mainPages = [
      const SurahNamePage(),
      Container(),
      Container(),
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentNavigatorIndex = context.select<MainState, int>((s) => s.bottomNavigatorIndex);
    final appLocale = AppLocalizations.of(context);
    final appColors = Theme.of(context).colorScheme;
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: IndexedStack(
          key: ValueKey(currentNavigatorIndex),
          children: _mainPages,
        ),
      ),
      bottomNavigationBar: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [
                appColors.primary.withAlpha(0),
                appColors.primary.withAlpha(15),
                appColors.primary.withAlpha(35),
                appColors.primary.withAlpha(75),
                appColors.primary.withAlpha(95),
              ],
            ),
          ),
          child: Card(
            margin: AppPaddings.withoutTopMedium,
            shape: AppShapes.large,
            child: SalomonBottomBar(
              itemShape: AppShapes.large,
              selectedItemColor: appColors.primary,
              unselectedItemColor: appColors.onSurface.withAlpha(175),
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.line_style_rounded),
                  title: Text(appLocale.surah),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.bookmark_rounded),
                  title: Text(appLocale.bookmarks),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.circle_rounded),
                  title: Text(appLocale.juz),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.settings_rounded),
                  title: Text(appLocale.settings),
                ),
              ],
              currentIndex: currentNavigatorIndex,
              onTap: (int index) {
                if (currentNavigatorIndex != index) {
                  context.read<MainState>().setBottomNavigatorIndex(index);
                } else {
                  // _scrollController.animateTo(
                  //   0,
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.easeOutQuart,
                  // );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
