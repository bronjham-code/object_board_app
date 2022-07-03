import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/core/router/router_extensions.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  SignInView({
    super.key,
    Uri? source,
    Uri? target,
  })  : source = source ?? RouteMap.buildHomeLocation(),
        target = target ?? RouteMap.buildHomeLocation();

  final Uri source;
  final Uri target;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final AuthenticationGlobalState _authenticationGlobalState;

  Future<void> _onSuccess() async {
    await _authenticationGlobalState.signIn();
    if (mounted) {
      GoRouter.of(context).goUri(widget.target);
    }
  }

  Future<void> _onFailed() async {
    await _authenticationGlobalState.signOut();
    if (mounted) {
      GoRouter.of(context).goUri(widget.source);
    }
  }

  @override
  void initState() {
    _authenticationGlobalState = Provider.of(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn View'),
      ),
      body: Center(
        child: Wrap(
          runSpacing: 12,
          children: [
            TextButton(
              onPressed: _onSuccess,
              child: const Text('Success'),
            ),
            TextButton(
              onPressed: _onFailed,
              child: const Text('Failed'),
            ),
          ],
        ),
      ),
    );
  }
}
