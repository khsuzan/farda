part of '../_screens.dart';

@RoutePage()
class ScreenDashboardShell extends StatelessWidget {
  const ScreenDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [RouteHome(), RoutePlan(), RouteCalendar(), RouteMore()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavBar(
          onSelect: tabsRouter.setActiveIndex,
          index: tabsRouter.activeIndex,
        );
      },
    );
  }
}
