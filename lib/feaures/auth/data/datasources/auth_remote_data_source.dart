import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithMobile(String mobile);
  Future<UserModel> signInWithEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> signInWithGoogle() async {
    // 1. Authenticate with Google
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    // 2. Extract the authentication properties (returns idToken and serverAuthCode)
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // 3. Pass only the idToken to Firebase (accessToken is null)
    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: null, // Safe to set as null for Firebase
    );

    // 4. Sign in to Firebase
    final UserCredential userCredential = await firebaseAuth
        .signInWithCredential(credential);
    if (userCredential.user == null) throw Exception("Firebase user is null.");

    return UserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status != LoginStatus.success) {
      throw Exception("Facebook sign in failed or aborted: ${result.message}");
    }

    final OAuthCredential credential = FacebookAuthProvider.credential(
      result.accessToken!.tokenString,
    );
    final UserCredential userCredential = await firebaseAuth
        .signInWithCredential(credential);
    if (userCredential.user == null) throw Exception("Firebase user is null.");

    return UserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<UserModel> signInWithEmail(String email) async {
    throw UnimplementedError(
      "Email implementation details pending password structure.",
    );
  }

  @override
  Future<UserModel> signInWithMobile(String mobile) async {
    throw UnimplementedError(
      "Mobile phone auth verification flow pending project setup.",
    );
  }
}
