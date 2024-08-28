import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/home/providers/state.provider.dart';

class BottomNavigationCommon extends ConsumerWidget {
  const BottomNavigationCommon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationindex = ref.watch(bottomNavigationIndexProvider);
    final gorouterProvider = ref.read(goRouterProvider);

    return BottomNavigationBar(
      currentIndex: navigationindex,
      onTap: (int newIndex) {
        if (newIndex == 1) {
          gorouterProvider.push('/scan-qr');
          ref.read(bottomNavigationIndexProvider.notifier).update((state) => 0);
        } else {
          ref
              .read(bottomNavigationIndexProvider.notifier)
              .update((state) => newIndex);
        }
      },
      elevation: 8,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
          ),
          label: 'Escanear DNI',
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person), label: 'Crear ingreso')
      ],
    );
  }
}
