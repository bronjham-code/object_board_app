import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/application_utils.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/core/router/router_extensions.dart';
import 'package:object_board_app/splash/domain/states/splash_global_state.dart';
import 'package:provider/provider.dart';
import 'package:simple_state/simple_state.dart';

class SplashView extends StatefulWidget {
  SplashView({
    super.key,
    Uri? target,
  }) : target = target ?? RouteMap.buildHomeLocation();

  final Uri target;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashGlobalState _splashGlobalState;

  Reaction? _reaction;

  void _initReaction() => _reaction = Reaction.when(
        listenables: [_splashGlobalState.isInitialized],
        condition: () => _splashGlobalState.isInitialized.value,
        reaction: () => GoRouter.of(context).goUri(widget.target),
      );

  Future<void> _setupApplication() => ApplicationUtils.setup(context);

  @override
  void initState() {
    _splashGlobalState = Provider.of(context, listen: false);
    _initReaction();
    _setupApplication();

    super.initState();
  }

  @override
  void dispose() {
    _reaction?.removeListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
