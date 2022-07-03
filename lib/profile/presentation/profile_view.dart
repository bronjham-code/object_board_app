import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
  Widget build(BuildContext context) {
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
}
