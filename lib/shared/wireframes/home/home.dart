import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
import 'package:ser_manos/shared/molecules/input/text_field.dart';
import 'package:ser_manos/shared/tokens/border_radius.dart';

import '../../molecules/input/search_field.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class Voluntariado {
  final String type;
  final String name;
  final String description;
  final String imageUrl;
  final int vacants;

  Voluntariado({
    required this.type,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.vacants = 0,
  });
}

class HomePage extends StatelessWidget {
  final List<Voluntariado> voluntariados = [
    Voluntariado(
      type: "Tipo 1",
      name: "Título 1",
      description: "Descripción 1",
      imageUrl: "https://picsum.photos/300/200",
      vacants: 3,
    ),
    Voluntariado(
      type: "Tipo 2",
      name: "Título 2",
      description: "Descripción 2",
      imageUrl: "https://picsum.photos/300/200",
    ),
    Voluntariado(
      type: "Tipo 2",
      name: "Título 2",
      description: "Descripción 2",
      imageUrl: "https://picsum.photos/300/200",
    ),
    Voluntariado(
      type: "Tipo 2",
      name: "Título 2",
      description: "Descripción 2",
      imageUrl: "https://picsum.photos/300/200",
    ),
  ];

  HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
          child: SearchField(
            hintText: 'Buscar',
            emptySuffix: const AppIcon(
              icon: AppIcons.MAPA,
              color: AppIconsColor.PRIMARY,
            ),
            onChanged: (query) {
              // filter your list…
            },
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Voluntariados", style: AppTypography.headline01),
              const SizedBox(height: 16),
              voluntariados.isNotEmpty ? Expanded(child:
                ListView.builder(
                  itemCount: voluntariados.length,
                  itemBuilder: (context, index) {
                    final voluntariado = voluntariados[index];
                    return Padding(padding:  const EdgeInsets.symmetric(vertical: 12.0),
                      child: CardVoluntariado(type: voluntariado.type,
                          name: voluntariado.name, imgUrl: voluntariado.imageUrl));
                  },
                )
              ) : Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppColors.neutral0,
                  borderRadius: AppBorderRadius.border4
                ),
                child: const Text("Actualmente no hay voluntariados vigentes. Pronto se irán ircorporando nuevos",
                  style: AppTypography.subtitle01,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}