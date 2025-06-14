
import 'package:freezed_annotation/freezed_annotation.dart';

part 'novedad.freezed.dart';
part 'novedad.g.dart';

@freezed
class Novedad with _$Novedad {
  const factory Novedad({
    required String id,
    required String titulo,
    required String resumen,
    required String emisor,
    required String imagenUrl,
    required String descripcion,
    required DateTime createdAt,
  }) = _Novedad;

  factory Novedad.fromJson(Map<String, dynamic> json) => _$NovedadFromJson(json);
}
