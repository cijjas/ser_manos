import 'package:flutter/cupertino.dart';

import '_app_icon.dart';
import 'mostrar_icon.dart';

enum FavoritoStyle { filled, outline }

class FavoritoIcon extends StatelessWidget {
  final FavoritoStyle style;
  final IconState estado;
  final double size;

  const FavoritoIcon({
    super.key,
    this.style = FavoritoStyle.filled,
    this.estado = IconState.defaultState,
    this.size = 24,
  });

  String _getAssetName() {
    final styleStr = style == FavoritoStyle.filled ? 'filled' : 'outline';
    final estadoStr = switch (estado) {
      IconState.disabled => 'disabled',
      IconState.active => 'active',
      _ => 'default',
    };
    return 'favorito_${styleStr}_$estadoStr';
  }

  @override
  Widget build(BuildContext context) {
    return AppIcon(name: _getAssetName(), size: size);
  }
}