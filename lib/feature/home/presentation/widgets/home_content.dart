import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/home/providers/visits_provider.dart';
import 'package:nodo_app_2/shared/shared_wapper.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  // Future _refreshVisits(WidgetRef ref) async {
  //   // Refresca el provider para recargar los datos
  //   // ignore: unused_result
  //   await ref.refresh(visitsProvider.future);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final currentVisitsList = ref.watch(currentVisitsProvider);
    final currentDate = IntlService().getCurrentDateFormatted();

    return currentVisitsList.when(
      data: (visits) => Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Visitantes: $currentDate',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(currentVisitsProvider.future),
                child: visits.isEmpty
                    ? const Center(
                        child: Text('No hay visitas cargadas el día de hoy'))
                    : ListView.builder(
                        itemCount: visits.length,
                        itemBuilder: (context, index) {
                          final visit = visits[index];
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  ref
                                      .read(goRouterProvider)
                                      .push('/visit-detail/${visit.id}');
                                },
                                leading: const Icon(
                                  Icons.date_range_outlined,
                                  size: 40,
                                ),
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('${visit.persona.apellido} '),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('${visit.persona.nombre} '),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 3),
                                    // Row(
                                    //   children: [Text(visit.motivo)],
                                    // ),
                                    Row(
                                      children: [Text(visit.persona.funcion)],
                                    ),
                                    Row(
                                      children: [
                                        Text('DNI: ${visit.persona.dni}')
                                      ],
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
