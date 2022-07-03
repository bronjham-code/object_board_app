import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/core/widgets/application_manager.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';

class RouterRedirect {
  RouterRedirect({
    required this.applicationManagerKey,
    required this.routesWithAuthentication,
  });

  @protected
  final List<Uri> routesWithAuthentication;

  @protected
  GlobalKey<ApplicationManagerState> applicationManagerKey;

  String? generalRedirect(GoRouterState state) {
    // final location = Uri.parse(state.location).path;
    // final splashUri = RouteMap.buildSplashLocation();
    // if (location != splashUri.path && !applicationGlobalState.isInitialized.value) {
    //   return RouteMap.buildSplashLocation(target: Uri.parse(location)).toString();
    // } else if (location == splashUri.path) {
    //   return null;
    // }

    return _authenticationRedirect(state);
  }

  String? _authenticationRedirect(GoRouterState state) {
    final location = Uri.parse(state.location);
    final isAuthRequired = routesWithAuthentication.any((e) => _isRouteEquals(e, location));
    final authenticationGlobalState = applicationManagerKey.currentState!.getGlobalState<AuthenticationGlobalState>()!;

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
