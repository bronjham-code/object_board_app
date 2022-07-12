import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';
import 'package:provider/provider.dart';

class RouterRedirect {
  RouterRedirect({
    required this.routesWithAuthentication,
  });

  @protected
  final List<Uri> routesWithAuthentication;

  String? generalRedirect(GoRouterState state, BuildContext context) => _authenticationRedirect(state, context);

  String? _authenticationRedirect(GoRouterState state, BuildContext context) {
    final location = Uri.parse(state.location);
    final isAuthRequired = routesWithAuthentication.any((e) => _isRouteEquals(e, location));
    final authenticationGlobalState = Provider.of<AuthenticationGlobalState>(context, listen: false);

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
