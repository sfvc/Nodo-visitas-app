import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodo_app_2/feature/home/presentation/home_screen.dart';

final goRouterProvider = Provider((ref) {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/ingresos',
      builder: (context, state) => const Center(child: Text('Ingresos')),
    ),
  ]);
});
