import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@GenerateMocks([
  FirebaseAuth,
  FirebaseAnalytics,
  FirebaseCrashlytics,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  UserCredential,
], customMocks: [
  MockSpec<User>(as: #MockFirebaseUser),
])
void main() {}
