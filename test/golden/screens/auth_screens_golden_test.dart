import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' show UserCredential;
import 'package:mockito/mockito.dart';
import 'package:ser_manos/shared/wireframes/ingreso/entry_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso/welcome_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso/login_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso/register_page.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import '../../mocks/mocks.mocks.dart';

class _FakeUserCredential extends Fake implements UserCredential {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthService mockAuth;
  late MockUserService mockUser;
  late UserCredential  fakeCred;

  setUp(() {
    mockAuth = MockAuthService();
    mockUser = MockUserService();
    fakeCred = _FakeUserCredential();

    when(mockAuth.signIn(any, any)).thenAnswer((_) async => fakeCred);
    when(mockAuth.register(any, any)).thenAnswer((_) async => fakeCred);
    when(mockAuth.signOut()).thenAnswer((_) async {});
  });

  Future<Widget> wrap(Widget child) async {
    return ProviderScope(
      overrides: [
        authServiceProvider.overrideWithValue(mockAuth),
        userServiceProvider.overrideWithValue(mockUser),
      ],
      child: MaterialApp(home: child),
    );
  }

  // ─────────────────────────────────────────────────────────
  testGoldens('Entry & Welcome screens', (tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone])
      ..addScenario(name: 'Entry',    widget: await wrap(const EntryPage()))
      ..addScenario(name: 'Welcome',  widget: await wrap(const WelcomePage()));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'auth_entry_welcome');
  });

  // ─────────────────────────────────────────────────────────
  testGoldens('Login & Register screens', (tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone])
      ..addScenario(name: 'Login',    widget: await wrap(const LoginPage()))
      ..addScenario(name: 'Register', widget: await wrap(const RegisterPage()));

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'auth_login_register');
  });
}
