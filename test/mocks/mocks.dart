import 'package:mockito/annotations.dart';

import 'package:ser_manos/services/news_service.dart';
import 'package:ser_manos/services/user_service.dart';
import 'package:ser_manos/services/volunteering_service.dart';
import 'package:ser_manos/services/auth_service.dart';

@GenerateNiceMocks([
  MockSpec<NewsService>(),
  MockSpec<UserService>(),
  MockSpec<VolunteeringService>(),
  MockSpec<AuthService>()
])
void main() {}
