import 'package:auto_route/auto_route.dart';
import 'package:farda/routes/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // RedirectRoute(path: '/', redirectTo: '/dashboard'),
    AutoRoute(page: RouteOnboard.page, path: '/'),
    AutoRoute(page: RouteLogin.page),
    AutoRoute(page: RouteOtpVerify.page),
    AutoRoute(page: RouteConnectOnboard.page),
    AutoRoute(page: RouteSubscription.page),
    AutoRoute(page: RoutePrescription.page),
    AutoRoute(page: RouteEmoji.page),
    AutoRoute(
      page: RouteDashboardShell.page,
      path: '/dashboard',
      children: [
        RedirectRoute(path: '', redirectTo: 'calendar'),

        AutoRoute(page: RouteHome.page, path: 'home'),
        AutoRoute(page: RoutePlan.page, path: 'plan'),
        AutoRoute(page: RouteCalendar.page, path: 'calendar'),
        AutoRoute(page: RouteMore.page, path: 'more'),
      ],
    ),
    AutoRoute(page: RouteMoodCheckIn.page, path: '/mood'),
    AutoRoute(page: RouteCalibration.page, path: '/calibration'),
  ];
}
