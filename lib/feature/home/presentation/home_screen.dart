import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/home/home_wrapper.dart';
import 'package:nodo_app_2/feature/home/providers/state.provider.dart';
import 'package:nodo_app_2/shared/shared_wapper.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Row(children: [
          Text(
            '¡Hola Nodo!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                // ref.read(goRouterProvider).push('/notifications');
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: const SafeArea(
        child: _HomeBody(),
      ),
      bottomNavigationBar: const BottomNavigationCommon(),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationIndex = ref.watch(bottomNavigationIndexProvider);
    switch (navigationIndex) {
      case 0:
        return const VisitsContent();
      // case 1:
      // se ignora ya que este boton lleva a la pantalla de escaneo de documento
      case 2:
        return FormIngresos();
      default:
        return const VisitsContent();
    }
  }
}
