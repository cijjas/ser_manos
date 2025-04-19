// mostrar_icon.dart
import 'package:flutter/cupertino.dart';

import '_app_icon.dart';

enum MostrarState { visible, oculto }
enum IconState { defaultState, disabled, active }

class MostrarIcon extends StatelessWidget {
  final MostrarState tipo;
  final IconState estado;
  final double size;

  const MostrarIcon({
    super.key,
    this.tipo = MostrarState.visible,
    this.estado = IconState.defaultState,
    this.size = 24,
  });

  String _getAssetName() {
    final tipoStr = tipo == MostrarState.visible ? 'visible' : 'oculto';
    final estadoStr = switch (estado) {
      IconState.disabled => 'disabled',
      IconState.active => 'active',
      _ => 'default',
    };
    return 'mostrar_${tipoStr}_$estadoStr';
  }

  @override
  Widget build(BuildContext context) {
    return AppIcon(name: _getAssetName(), size: size);
  }
}