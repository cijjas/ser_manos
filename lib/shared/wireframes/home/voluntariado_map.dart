  // import 'package:flutter/material.dart';
  // import 'package:google_maps_flutter/google_maps_flutter.dart';
  // import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
  // import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
  // import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
  // import '../../molecules/input/search_field.dart';
  // import '../../tokens/colors.dart';
  //
  //
  // class VoluntariadoMapPage extends StatelessWidget {
  //   final Voluntariado voluntariado;
  //
  //   const VoluntariadoMapPage({super.key, required this.voluntariado});
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       backgroundColor: AppColors.neutral0,
  //       body: Stack(
  //         children: [
  //           // -------- MAPA --------
  //
  //
  //           // -------- SEARCH BAR (opcional) --------
  //           Positioned(
  //             top: MediaQuery.of(context).padding.top + 12,
  //             left: 24,
  //             right: 24,
  //             child: SearchField(
  //               hintText: 'Buscar',
  //               emptySuffix: const AppIcon(
  //                 icon: AppIcons.LISTA,
  //                 color: AppIconsColor.PRIMARY,
  //               ),
  //               onChanged: (_) {},
  //             ),
  //           ),
  //
  //           // -------- CARRUSEL  --------
  //           Positioned(
  //             left: 0,
  //             right: 0,
  //             bottom: 0,
  //             height: 290,
  //             child: PageView(
  //               controller: PageController(viewportFraction: 0.9),
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
  //                   child: CardVoluntariado(
  //                     type: voluntariado.type,
  //                     name: voluntariado.name,
  //                     imgUrl: voluntariado.imageUrl,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }