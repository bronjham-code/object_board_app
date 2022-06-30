import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/conversations/presentation/conversations_view.dart';
import 'package:object_board_app/core/router/router_extensions.dart';
import 'package:object_board_app/home/presentation/home_view.dart';
import 'package:object_board_app/profile/presentation/profile_view.dart';
import 'package:object_board_app/profile/presentation/sign_in_view.dart';
import 'package:object_board_app/splash/presentation/splash_view.dart';

class RouteMap {
  static const _splashPath = 'splash';
  static const _profilePath = 'profile';
  static const _signInPath = 'sign-in';

  static const _conversationsPath = 'conversations';

  static const _sourceParam = 'source';
  static const _targetParam = 'target';

  /// Build [SplashView] location route
  static Uri buildSplashLocation({Uri? target}) => Uri(
        path: '/$_splashPath',
        queryParameters: {
          if (target != null) _targetParam: Uri.encodeComponent(target.toString()),
        },
      );

  /// Build [HomeView] location route
  static Uri buildHomeLocation() => Uri(path: '/');

  /// Build [ProfileView] location route
  static Uri buildProfileLocation() => Uri(path: '/$_profilePath');

  /// Build [SignInView] location route
  static Uri buildSignInLocation({Uri? source, Uri? target}) => Uri(
        path: '/$_signInPath',
        queryParameters: {
          if (source != null) _sourceParam: Uri.encodeComponent(source.toString()),
          if (target != null) _targetParam: Uri.encodeComponent(target.toString()),
        },
      );

  /// Build [ConversationsView] location route
  static Uri buildConversationsLocation() => Uri(path: '/$_conversationsPath');

  List<Uri> get routesWithAuthentication => [
        buildProfileLocation(),
      ];

  final _routesWithWrapper = [
    buildHomeLocation(),
    buildConversationsLocation(),
  ];

  final _routesWithFullScreen = [
    buildSignInLocation(),
  ];

  int? wrapperIndexOf(Uri location) {
    final index = _routesWithWrapper.indexWhere((route) => route.path == location.path);

    return index > -1 ? index : null;
  }

  List<GoRoute> buildMap() {
    return [
      GoRoute(
        path: '/$_splashPath',
        builder: (_, state) {
          final target = state.queryParams[_targetParam];

          return SplashView(
            target: target?.isNotEmpty == true ? Uri.tryParse(Uri.decodeComponent(target!)) : null,
          );
        },
      ),
      GoRoute(
        path: '/',
        builder: (_, __) => const HomeView(),
        routes: [
          GoRoute(
            path: _conversationsPath,
            builder: (_, __) => const ConversationsView(),
            routes: [],
          ),
          GoRoute(
            path: _profilePath,
            builder: (_, __) => const ProfileView(),
          ),
          GoRoute(
            path: _signInPath,
            builder: (_, state) {
              final source = state.queryParams[_sourceParam];
              final target = state.queryParams[_targetParam];

              return SignInView(
                source: source?.isNotEmpty == true ? Uri.tryParse(Uri.decodeComponent(source!)) : null,
                target: target?.isNotEmpty == true ? Uri.tryParse(Uri.decodeComponent(target!)) : null,
              );
            },
          ),
        ],
      ),
    ];
  }

  Widget navigatorBuilder(BuildContext context, GoRouterState state, Widget child) {
    final uriLocation = Uri.parse(state.location);
    final wrapperIndex = wrapperIndexOf(uriLocation);

    return Navigator(
      onPopPage: (route, dynamic result) {
        route.didPop(result);
        return false;
      },
      pages: [
        MaterialPage<void>(
          child: wrapperIndex != null
              ? ScaffoldMainWrapper(
                  index: wrapperIndex,
                  child: child,
                )
              : child,
        ),
      ],
    );
  }
}

class ScaffoldMainWrapper extends StatelessWidget {
  const ScaffoldMainWrapper({
    super.key,
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  void _onNavigationTap(BuildContext context, int index) {
    late final Uri location;

    switch (index) {
      case 1:
        location = RouteMap.buildConversationsLocation();
        break;
      default:
        location = RouteMap.buildHomeLocation();
    }
    GoRouter.of(context).goUri(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Conversations'),
        ],
        onTap: (index) => _onNavigationTap(context, index),
      ),
    );
  }
}
