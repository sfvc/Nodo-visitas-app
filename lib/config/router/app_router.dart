import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodo_app_2/feature/home/home_wrapper.dart';

final goRouterProvider = Provider((ref) {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/visit-detail/:id',
      builder: (context, state) {
        final visitId = state.pathParameters['id']!;
        return VisitDetail(visitId: visitId);
      },
    ),
    GoRoute(
      path: '/form-ingreso',
      builder: (context, state) => FormIngresos(),
    ),
    GoRoute(
      path: '/scan-qr',
      builder: (context, state) => const QRScannerScreen(),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => const TestScreen(),
    ),
  ]);
});
