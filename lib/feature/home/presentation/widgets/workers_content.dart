// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nodo_app_2/config/router/app_router.dart';
// import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
// import 'package:nodo_app_2/feature/ingresos/providers/visits_provider.dart';

// final dniProvider = StateProvider<String>((ref) => '');

// class WorkersScreen extends ConsumerWidget {
//   const WorkersScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final colors = Theme.of(context).colorScheme;
//     final empleadosProvider = ref.watch(employesProvider);
//     return empleadosProvider.when(
//       data: (empleados) => Column(
//         children: [
//           const SizedBox(height: 10),
//           const Text(
//             'Todas las visitas: ',
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Form(
//               child: TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Buscar empleados',
//                   hintText: 'Ingrese documento',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.search),
//                 ),
//                 onChanged: (value) {
//                   // ref
//                   //     .read(dniProvider.notifier)
//                   //     .update(value as String Function(String state));
//                 },
//                 onEditingComplete: () {
//                   // ref.refresh(searchPersonaByDniProvider(dniToSearch));
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           // dniToSearch.isEmpty
//           //     ? _listOfEmpleados(ref, empleados, colors)
//           //     : Text('buscando algo')

//           _listOfEmpleados(ref, empleados, colors),
//         ],
//       ),
//       error: (error, stackTrace) {
//         return const Center(
//             child: Text(
//                 'Error al cargar la lista de estaciones, pruebe mas tarde'));
//       },
//       loading: () {
//         return const Center(child: Text('Cargando ...'));
//       },
//     );
//   }

//   Expanded _listOfEmpleados(
//       WidgetRef ref, List<Persona> empleados, ColorScheme colors) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
//         child: RefreshIndicator(
//           onRefresh: () => ref.refresh(employesProvider.future),
//           child: empleados.isEmpty
//               ? const Center(child: Text('No hay visitas cargadas '))
//               : ListView.builder(
//                   itemCount: empleados.length,
//                   itemBuilder: (context, index) {
//                     final persona = empleados[index];
//                     return Column(
//                       children: [
//                         ListTile(
//                           onTap: () {
//                             ref
//                                 .read(goRouterProvider)
//                                 .push('/visit-detail/${persona.dni}');
//                           },
//                           leading: const Icon(
//                             Icons.account_circle_outlined,
//                             size: 40,
//                           ),
//                           title: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text('${persona.apellido} '),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Text('${persona.nombre} '),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 3),
//                               // Row(
//                               //   children: [Text(visit.motivo)],
//                               // ),
//                               // Row(
//                               //   children: [Text(persona.funcion)],
//                               // ),
//                               Row(
//                                 children: [Text('DNI: ${persona.dni}')],
//                               ),
//                               // Row(
//                               //   children: [Text('Id: ${persona.id}')],
//                               // ),
//                             ],
//                           ),
//                           isThreeLine: false,
//                         ),
//                         Divider(
//                           height: 10,
//                           color: colors.primary,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }


// // class SearchContent extends ConsumerWidget {
//   // const SearchContent({super.key});

//   // @override
//   // Widget build(BuildContext context, WidgetRef ref) {
//   //   final colors = Theme.of(context).colorScheme;

//   //   final visitsList = ref.watch(visitsProvider);

//     // return visitsList.when(
//     //   data: (visits) => Column(
//     //     children: [
//     //       const SizedBox(height: 10),
//     //       const Text(
//     //         'Todas las visitas: ',
//     //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//     //       ),
//     //       Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Form(
//     //           child: TextField(
//     //             decoration: const InputDecoration(
//     //               labelText: 'Buscar visitas',
//     //               border: OutlineInputBorder(),
//     //               prefixIcon: Icon(Icons.search),
//     //             ),
//     //             onChanged: (value) {},
//     //           ),
//     //         ),
//     //       ),
//     //       const SizedBox(height: 20),
//     //       _listOfVisits(ref, visits, colors),
//     //     ],
//     //   ),
//     //   error: (error, stackTrace) {
//     //     return const Center(
//     //         child: Text(
//     //             'Error al cargar la lista de estaciones, pruebe mas tarde'));
//     //   },
//     //   loading: () {
//     //     return const Center(child: Text('Cargando ...'));
//     //   },
//     // );
//   // }
