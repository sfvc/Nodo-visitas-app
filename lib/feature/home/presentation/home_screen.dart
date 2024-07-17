import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
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
      floatingActionButton: FilledButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('NUEVO'),
        onPressed: () {
          ref.read(goRouterProvider).push('/form-ingreso');
        },
      ),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationIndex = ref.watch(bottomNavigationIndexProvider);

    switch (navigationIndex) {
      case 0:
        return const HomeContent();
      case 1:
        return const SearchContent();
      case 2:
        return const WorkersScreen();
      default:
        return const HomeContent();
    }
  }
}
