
import 'package:flutter/cupertino.dart';

import '../cells/cards/card_novedades.dart';
import '../cells/cards/card_voluntariado_actual.dart';
import '../cells/header/header.dart';

class CardTestPage extends StatelessWidget {
  const CardTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppHeader(body:
    Column(
        spacing: 16,
        children: [
          CardNovedades(type: "Reporte 2820", name: "Ser donante voluntario",
              description: "Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre sad asdasdasd asdsadaa aaaaaaaa",
              imgUrl: 'https://picsum.photos/300/200'),
          CardVoluntariadoActual(
              type: "Accion Social",
              name: "Un techo para mi pais"
          )
        ]
    )
    );
  }
}