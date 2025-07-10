import 'package:mockito/annotations.dart';

import 'package:ser_manos/services/novedad_service.dart';
import 'package:ser_manos/services/user_service.dart';
import 'package:ser_manos/services/volunteering_service.dart';
import 'package:ser_manos/services/auth_service.dart';

@GenerateNiceMocks([
  MockSpec<NovedadService>(),
  MockSpec<UserService>(),
  MockSpec<VolunteeringService>(),
  MockSpec<AuthService>()
])
void main() {}
