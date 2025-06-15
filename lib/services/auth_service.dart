import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AuthService {
  AuthService({
    FirebaseAuth? auth,
    FirebaseAnalytics? analytics,
    FirebaseCrashlytics? crashlytics,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _analytics = analytics ?? FirebaseAnalytics.instance,
        _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  final FirebaseAuth _auth;
  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;

  static const nonCriticalErrors = {
    'wrong-password',
    'user-not-found',
    'invalid-email',
    'email-already-in-use',
    'weak-password',
  };

  Future<UserCredential> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _analytics.logEvent(
        name: 'sign_up',
        parameters: {
          'method': 'email',
        },
      );
      return result;
    } on FirebaseAuthException catch (e, stack) {
      final isExpected = nonCriticalErrors.contains(e.code);

      if (!isExpected) {
        _crashlytics.recordError(
          e,
          stack,
          reason: 'Unexpected FirebaseAuthException during register',
          fatal: false,
        );
      }

      _analytics.logEvent(
        name: 'auth_error',
        parameters: {
          'stage': 'register',
          'method': 'email',
          'error_code': e.code,
        },
      );

      rethrow;
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _analytics.logEvent(
        name: 'sign_in',
        parameters: {
          'method': 'email',
        },
      );
      return result;
    } on FirebaseAuthException catch (e, stack) {
      final isExpected = nonCriticalErrors.contains(e.code);

      if (!isExpected) {
        _crashlytics.recordError(
          e,
          stack,
          reason: 'Unexpected FirebaseAuthException during sign in',
          fatal: false,
        );
      }

      _analytics.logEvent(
        name: 'auth_error',
        parameters: {
          'stage': 'sign_in',
          'method': 'email',
          'error_code': e.code,
        },
      );

      rethrow;
    }

  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
