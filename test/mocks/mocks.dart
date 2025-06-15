// test/mocks/mocks.dart
import 'package:mockito/annotations.dart';

import 'package:ser_manos/services/novedad_service.dart';
import 'package:ser_manos/services/user_service.dart';
import 'package:ser_manos/services/voluntariado_service.dart';

@GenerateNiceMocks([
  MockSpec<NovedadService>(),
  MockSpec<UserService>(),
  MockSpec<VoluntariadoService>(),
])
void main() {}
