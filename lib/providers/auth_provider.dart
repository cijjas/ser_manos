import 'package:flutter_riverpod/flutter_riverpod.dart';
// ESTO NO ES NADA SOLO ESTABA VIENDO COMMO FUNCIONA ESTO pero bueno quizas se necesita despues
class AuthState {
  final bool isLoggedIn;
  const AuthState({required this.isLoggedIn});
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState(isLoggedIn: false);

  void login() => state = const AuthState(isLoggedIn: true);
  void logout() => state = const AuthState(isLoggedIn: false);
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() => AuthNotifier());
