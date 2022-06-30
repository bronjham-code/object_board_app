import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/core/router/router_extensions.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).goUri(RouteMap.buildProfileLocation()),
        tooltip: 'Authentication required',
        child: const Icon(Icons.person),
      ),
    );
  }
}
