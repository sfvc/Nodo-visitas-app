import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/home/providers/state.provider.dart';

class BottomNavigationCommon extends ConsumerWidget {
  const BottomNavigationCommon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationindex = ref.watch(bottomNavigationIndexProvider);

    return BottomNavigationBar(
      currentIndex: navigationindex,
      onTap: (newvalue) =>
          ref.read(bottomNavigationIndexProvider.notifier).update(
                (state) => newvalue,
              ),
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Personal')
      ],
    );
  }
}
