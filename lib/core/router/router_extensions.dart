import 'package:go_router/go_router.dart';

extension GoRouterExtensions on GoRouter {
  void goUri(Uri location, {Object? extra}) => go(location.toString(), extra: extra);
}
