import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/resources/resources.dart';
import 'package:onai_docs/src/features/app/router/app_router.dart';
import 'package:onai_docs/src/features/app/widgets/custom/custom_tab_bar_widget.dart';

// ignore: unused_element
const _tag = 'Base';

class Base extends StatefulWidget {
  final int? initialTabIndex;

  const Base({
    super.key,
    this.initialTabIndex,
  });

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> with TickerProviderStateMixin {
  TabController? tabController;

  int previousIndex = 0;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: widget.initialTabIndex ?? 0,
      length: 4,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        MainRoute(),
        TaskRoute(),
        NotificationRoute(),
        ProfileRoute(),
      ],
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      transitionBuilder: (context, child, animation) {
        return SafeArea(
          bottom: false,
          maintainBottomViewPadding: true,
          child: child,
        );
      }, //////   IMPORTANT
      backgroundColor: AppColors.kGlobalBackground,
      bottomNavigationBuilder: (_, tabsRouter) {
        // tabsRouter.setActiveIndex(tabController!.index);
        return Container(
          padding: EdgeInsets.only(bottom: Platform.isIOS ? 25.0 : 8.0, top: 7),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: AppColors.kWhite,
            boxShadow: AppDecorations.dropShadow,
          ),
          child: TabBar(
            onTap: (value) {
              // previousIndex = tabsRouter.previousIndex ?? 0;
              // if (tabsRouter.activeIndex == value) {
              //   tabsRouter.popTop();
              // } else {
              tabsRouter.setActiveIndex(value);
              // }
            },
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            controller: tabController,
            labelPadding: EdgeInsets.zero,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            tabs: [
              CustomTabWidget(
                icon: 'assets/icons/home_tab.svg',
                activeIcon: 'assets/icons/home_tab.svg',
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 0,
                title: 'Главная',
              ),
              CustomTabWidget(
                icon: 'assets/icons/task_tab.svg',
                activeIcon: 'assets/icons/task_tab.svg',
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 1,
                title: 'Задачи',
              ),
              CustomTabWidget(
                icon: 'assets/icons/notification_tab.svg',
                activeIcon: 'assets/icons/notification_tab.svg',
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 2,
                title: 'Уведомления',
              ),
              CustomTabWidget(
                icon: 'assets/icons/profile_tab.svg',
                activeIcon: 'assets/icons/profile_tab.svg',
                currentIndex: tabsRouter.activeIndex,
                tabIndex: 3,
                title: 'Профиль',
              ),
            ],
          ),
        );
      },
    );
  }
}
