import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';
import 'package:object_board_app/splash/domain/states/splash_global_state.dart';

class RouterRedirect {
  RouterRedirect({
    required this.splashGlobalState,
    required this.routesWithAuthentication,
    required this.authenticationGlobalState,
  });

  @protected
  final List<Uri> routesWithAuthentication;

  @protected
  final SplashGlobalState splashGlobalState;

  @protected
  final AuthenticationGlobalState authenticationGlobalState;

  String? generalRedirect(GoRouterState state) {
    final location = Uri.parse(state.location).path;
    final splashUri = RouteMap.buildSplashLocation();
    if (location != splashUri.path && !splashGlobalState.isInitialized.value) {
      return RouteMap.buildSplashLocation(target: Uri.parse(location)).toString();
    }

    return _authenticationRedirect(state);
  }

  String? _authenticationRedirect(GoRouterState state) {
    final location = Uri.parse(state.location);
    final isAuthRequired = routesWithAuthentication.any((e) => _isRouteEquals(e, location));

    if (isAuthRequired && !authenticationGlobalState.isAuthenticated.value) {
      return RouteMap.buildSignInLocation(
        target: Uri.parse(location.path),
      ).toString();
    }

    return null;
  }

  bool _isRouteEquals(Uri mask, Uri route) {
    final maskSegments = mask.pathSegments;
    final routeSegments = route.pathSegments;

    if (maskSegments.length != routeSegments.length) {
      return false;
    }

    for (int i = 0; i < routeSegments.length; i++) {
      final maskSegment = maskSegments[i];
      final routeSegment = routeSegments[i];

      if (maskSegment == routeSegment || maskSegment.startsWith(':')) {
        continue;
      }

      return false;
    }

    return true;
  }
}
