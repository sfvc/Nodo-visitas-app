import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/ingresos/domain/entiy/visit_entity.dart';
import 'package:nodo_app_2/feature/ingresos/providers/visits_provider.dart';

class VisitsContent extends ConsumerWidget {
  const VisitsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final visitsList = ref.watch(visitsProvider);

    return visitsList.when(
      data: (visits) => Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Todas las visitas: ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Buscar visitas',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
          const SizedBox(height: 20),
          _listOfVisits(ref, visits, colors),
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

  Expanded _listOfVisits(
      WidgetRef ref, List<Visita> visits, ColorScheme colors) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(visitsProvider.future),
          child: visits.isEmpty
              ? const Center(child: Text('No hay visitas cargadas '))
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
                            Icons.event_repeat_outlined,
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
                                children: [Text('DNI: ${visit.persona.dni}')],
                              ),
                              Row(
                                children: [Text('Id: ${visit.id}')],
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
    );
  }
}
