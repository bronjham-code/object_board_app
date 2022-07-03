import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/core/router/router_extensions.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({
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

    return GoRouter.of(context).goUri(location);
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
