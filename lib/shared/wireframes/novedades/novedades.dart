import 'package:flutter/material.dart';
import 'package:ser_manos/shared/cells/cards/card_novedades.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import 'novedad.dart';


class NewsPage extends StatelessWidget {
  final List<Novedad> news = [
    const Novedad(
      type: "REPORTE 2820",
      name: "Ser donante voluntario",
      description: "Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de sangre.",
      imgUrl: "https://lh5.googleusercontent.com/proxy/OuqYGjWAyM26M0wMtUj7-GdVnykw9_I5BpVBd2-TaFGWHrXmsl4SUbE2eaTIy2JcBpebbbFhzqJemCa3Dgn_G_hvrOEhEqTqo_FD8b_8zbNmYSI7LhVmaNq7iUtF_hVWIs8sYE1FivmlO_FrmvADp_vPOiWpPSRVrr42tFk63FxZLyRdm46-qYfU0g",
    ),
    const Novedad(
      type: "CAMPAÑA 2025",
      name: "Apoyá la reforestación",
      description: "Sumate al programa de reforestación en parques nacionales para cuidar nuestro planeta.",
      imgUrl: "https://images.unsplash.com/photo-1506765515384-028b60a970df?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=60",
    ),
    const Novedad(
      type: "INICIATIVA",
      name: "Comedores comunitarios",
      description: "Más de 200 voluntarios se unieron para brindar alimentos a comunidades vulnerables.",
      imgUrl: "https://revistaquorum.com.ar/wp-content/uploads/2025/01/comedores.jpg",
    ),
    const Novedad(
      type: "EVENTO",
      name: "Carrera solidaria 10K",
      description: "Corré por una causa: lo recaudado se destinará a becas educativas para jóvenes en riesgo.",
      imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7RwpOjfnWy3fj35EkIfs48BR_DfgiwNywMQ&s",
    ),
  ];

  NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text("Novedades", style: AppTypography.headline01),
          const SizedBox(height: 16),
          ...news.map((newsPiece) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: CardNovedades(novedad: newsPiece),
          )),
        ],
      ),
    );
  }
}