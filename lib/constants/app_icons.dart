import 'package:flutter/material.dart';

enum AppIcons {
  MOSTRAR(Icons.visibility),
  MOSTAR_OUTLINE(Icons.visibility_outlined),
  OCULTAR(Icons.visibility_off),
  OCULTAR_OUTLINE(Icons.visibility_off_outlined),

  FAVORITO(Icons.favorite),
  FAVORITO_OUTLINE(Icons.favorite_outline),

  BUSCAR(Icons.search),

  ANADIR(Icons.add),

  ATRAS(Icons.arrow_back),

  CERRAR(Icons.close),

  UBICACION(Icons.location_on),
  UBICACION_OUTLINE(Icons.location_on_outlined),

  CALENDARIO(Icons.calendar_month),

  ERROR(Icons.error),
  ERROR_OUTLINE(Icons.error_outline),

  LISTA(Icons.list),

  MAPA(Icons.map),

  NAVEGACION(Icons.navigation),

  PERSONA(Icons.person);

  final IconData iconData;

  const AppIcons(this.iconData);

}

enum AppIconsColor {
  DEFAULT,
  DISABLED,
  PRIMARY,
  SECONDARY,
  SECONDARY_DISABLED,
  NEUTRAL_75;

  const AppIconsColor();

}