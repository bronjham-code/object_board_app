import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/widgets/content_view_state.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ContentViewState<ProfileView> {
  late final AuthenticationGlobalState _authenticationGlobalState;

  Future<void> _signOut() async {
    await _authenticationGlobalState.signOut();

    if (mounted) {
      GoRouter.of(context).pop();
    }
  }

  @override
  void initState() {
    _authenticationGlobalState = Provider.of(context, listen: false);

    super.initState();
  }

  @override
  Widget buildLoading(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile View'),
        ),
        body: const Center(
          child: FlutterLogo(
            size: 100,
          ),
        ),
      );

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
      ),
      body: Center(
        child: TextButton(
          onPressed: _signOut,
          child: const Text('SignOut'),
        ),
      ),
    );
  }

  @override
  Future<DataResult> onDataLoad() async {
    await Future.delayed(const Duration(seconds: 2));
    return DataResult.failed(reason: 'Object not found, please retry.');
  }
}
