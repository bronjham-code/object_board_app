import 'package:flutter/material.dart';
import 'package:object_board_app/core/client/client_utils.dart';
import 'package:object_board_app/core/repository/repository_utils.dart';
import 'package:object_board_app/core/state/state_utils.dart';
import 'package:object_board_app/core/storage/storage_utils.dart';
import 'package:object_board_app/onboarding/domain/states/onboarding_global_state.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';
import 'package:provider/provider.dart';

class ApplicationManager extends StatefulWidget {
  const ApplicationManager({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ApplicationManager> createState() => ApplicationManagerState();
}

class ApplicationManagerState extends State<ApplicationManager> {
  bool _isInitialized = false;

  final List<dynamic> _globalStates = [];

  Future<void> _setupApplication() async {
    await StorageUtils.setupStorage();
    await ClientUtils.setupClients();
    await RepositoryUtils.setupRepositories();
    await _createStates();
    await Future.delayed(const Duration(seconds: 3));

    _setupFinally();
  }

  Future<void> _createStates() async {
    final globalStates = await StateUtils.createStates();

    _globalStates
      ..clear()
      ..addAll(globalStates);
  }

  Provider<T> _createProvider<T>() => Provider<T>(create: (_) => _globalStates.whereType<T>().first);

  void _setupFinally() => setState(() => _isInitialized = true);

  @override
  void initState() {
    _setupApplication();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return MultiProvider(
      providers: [
        _createProvider<AuthenticationGlobalState>(),
        _createProvider<OnboardingGlobalState>(),
      ],
      child: widget.child,
    );
  }
}
