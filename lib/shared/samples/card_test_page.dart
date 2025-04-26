import 'package:flutter/material.dart';

import '../cells/header/header.dart';
import '../cells/cards/card_novedades.dart';
import '../cells/cards/card_voluntariado_actual.dart';
import '../cells/cards/card_informacion.dart';

/// ---------------------------------------------------------------------------
/// Página de pruebas de tarjetas (Novedades, Voluntariado, Información fija)
/// ---------------------------------------------------------------------------
class CardTestPage extends StatelessWidget {
  const CardTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppHeader(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ----------------------------------------------------------------
            // Tarjetas existentes
            // ----------------------------------------------------------------
            CardNovedades(
              type: 'Reporte 2820',
              name: 'Ser donante voluntario',
              description:
              'Desde el Hospital Centenario recalcan la importancia... '
                  'asdasdasd asdsadaa aaaaaaaa',
              imgUrl: 'https://picsum.photos/300/200',
            ),
            SizedBox(height: 16),

            CardVoluntariadoActual(
              type: 'Acción Social',
              name: 'Un techo para mi país',
            ),
            SizedBox(height: 16),

            // ----------------------------------------------------------------
            // Tarjetas de información (fijas: SIEMPRE 2 ítems)
            // ----------------------------------------------------------------
            CardInformacion(
              title: 'Título',
              label1: 'Label',
              content1: 'Content',
              label2: 'Label',
              content2: 'Content',
            ),
            SizedBox(height: 16),

            CardInformacion(
              title: 'Dirección',
              label1: 'Calle',
              content1: 'Av. Siempre Viva 742',
              label2: 'Ciudad',
              content2: 'Springfield',
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Punto de entrada independiente para lanzar esta pantalla directamente.
/// ---------------------------------------------------------------------------
void main() => runApp(const MaterialApp(home: CardTestPage()));