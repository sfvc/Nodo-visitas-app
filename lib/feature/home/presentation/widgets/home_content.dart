import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/home/providers/visits_provider.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final visitsList = ref.watch(visitsProvider);

    return visitsList.when(
      data: (visits) => Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Lista de visitantes',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: ListView.builder(
                itemCount: visits.length,
                itemBuilder: (context, index) {
                  final visit = visits[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.account_circle_outlined,
                          size: 40,
                        ),
                        title: Row(
                          children: [
                            const Icon(Icons.person),
                            const SizedBox(width: 8),
                            Text(
                                '${visit.persona.nombre} ${visit.persona.apellido}'),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 3),
                            Row(
                              children: [Text(visit.motivo)],
                            ),
                            Row(
                              children: [Text('DNI: ${visit.persona.dni}')],
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(visit.dia),
                            Text(visit.hora),
                          ],
                        ),
                        isThreeLine: false,
                      ),
                      Divider(
                        height: 10,
                        color: colors.primary,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      error: (error, stackTrace) {
        return const Center(
            child: Text(
                'Error al cargar la lista de estaciones, pruebe mas tarde'));
      },
      loading: () {
        return const Center(child: Text('Cargando ...'));
      },
    );
  }
}
