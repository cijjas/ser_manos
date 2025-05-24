import 'package:flutter_riverpod/flutter_riverpod.dart';

final isMapViewProvider = StateProvider<bool>((ref) => false); // false = ListView, true = MapView