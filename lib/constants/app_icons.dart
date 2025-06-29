import 'package:flutter/material.dart';

enum AppIcons {
  mostrar(Icons.visibility),
  mostrarOutline(Icons.visibility_outlined),
  ocultar(Icons.visibility_off),
  ocultarOutline(Icons.visibility_off_outlined),

  favorito(Icons.favorite),
  favoritoOutline(Icons.favorite_outline),

  buscar(Icons.search),

  anadir(Icons.add),

  atras(Icons.arrow_back),

  cerrar(Icons.close),

  ubicacion(Icons.location_on),
  ubicacionOutline(Icons.location_on_outlined),

  calendario(Icons.calendar_month),

  error(Icons.error),
  errorOutline(Icons.error_outline),

  lista(Icons.list),

  mapa(Icons.map),

  navegacion(Icons.navigation),

  persona(Icons.person);

  final IconData iconData;

  const AppIcons(this.iconData);
}

enum AppIconsColor {
  defaultColor,
  disabled,
  primary,
  secondary,
  secondaryDisabled,
  neutral75;

  const AppIconsColor();
}
