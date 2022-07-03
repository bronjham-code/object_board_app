import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/conversations/presentation/conversations_view.dart';
import 'package:object_board_app/home/presentation/home_view.dart';
import 'package:object_board_app/main/presentation/widgets/main_wrapper.dart';
import 'package:object_board_app/profile/presentation/profile_view.dart';
import 'package:object_board_app/profile/presentation/sign_in_view.dart';

class RouteMap {
  static const _profilePath = 'profile';
  static const _signInPath = 'sign-in';

  static const _conversationsPath = 'conversations';

  static const _sourceParam = 'source';
  static const _targetParam = 'target';

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

  final _mainWrapperRoutes = [
    buildHomeLocation(),
    buildConversationsLocation(),
  ];

  int? wrapperIndexOf(Uri location) {
    final index = _mainWrapperRoutes.indexWhere((route) => route.path == location.path);

    return index > -1 ? index : null;
  }

  List<GoRoute> buildMap() {
    return [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomeView(),
        routes: [
          GoRoute(
            path: _conversationsPath,
            builder: (_, __) => const ConversationsView(),
          ),
          GoRoute(
            path: _profilePath,
            builder: (_, __) => const ProfileView(),
          ),
          GoRoute(
            path: _signInPath,
            pageBuilder: (_, state) {
              final source = state.queryParams[_sourceParam];
              final target = state.queryParams[_targetParam];

              return MaterialPage(
                fullscreenDialog: true,
                child: SignInView(
                  source: source?.isNotEmpty == true ? Uri.tryParse(Uri.decodeComponent(source!)) : null,
                  target: target?.isNotEmpty == true ? Uri.tryParse(Uri.decodeComponent(target!)) : null,
                ),
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
      onPopPage: (route, result) {
        route.didPop(result);

        return false;
      },
      pages: [
        MaterialPage<void>(
          child: wrapperIndex != null
              ? MainWrapper(
                  index: wrapperIndex,
                  child: child,
                )
              : child,
        ),
      ],
    );
  }
}
