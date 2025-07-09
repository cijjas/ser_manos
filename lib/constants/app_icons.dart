import 'package:flutter/material.dart';

enum AppIcons {
  show(Icons.visibility),
  showOutline(Icons.visibility_outlined),
  hide(Icons.visibility_off),
  hideOutline(Icons.visibility_off_outlined),

  favorite(Icons.favorite),
  favoriteOutline(Icons.favorite_outline),

  search(Icons.search),

  add(Icons.add),

  back(Icons.arrow_back),

  close(Icons.close),

  location(Icons.location_on),
  locationOutline(Icons.location_on_outlined),

  calendar(Icons.calendar_month),

  error(Icons.error),
  errorOutline(Icons.error_outline),

  list(Icons.list),

  map(Icons.map),

  navigation(Icons.navigation),

  person(Icons.person);

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
