import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodo_app_2/feature/home/home_wrapper.dart';

final goRouterProvider = Provider((ref) {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ]);
});
