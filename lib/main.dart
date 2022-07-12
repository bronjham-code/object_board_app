import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/const/general_const.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/core/router/router_redirect.dart';
import 'package:object_board_app/core/theme/app_theme.dart';
import 'package:object_board_app/core/widgets/application_manager.dart';
import 'package:object_board_app/onboarding/presentation/onboarding_view.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  Application({super.key});

  final _innerKey = GlobalKey();

  late final _routeMap = RouteMap();

  late final _routeRedirect = RouterRedirect(
    routesWithAuthentication: _routeMap.routesWithAuthentication,
  );

  late final _router = GoRouter(
    // initialLocation: RouteMap.buildProfileLocation().toString(),
    debugLogDiagnostics: true,
    routes: _routeMap.buildMap(),
    redirect: (state) => _routeRedirect.generalRedirect(state, _innerKey.currentContext!),
    navigatorBuilder: _routeMap.navigatorBuilder,
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        title: GeneralConst.applicationTitle,
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        builder: (_, child) => ApplicationManager(
          child: OnboardingView(
            key: _innerKey,
            child: SizedBox(
              child: child,
            ),
          ),
        ),
      );
}
