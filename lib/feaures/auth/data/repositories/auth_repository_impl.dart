import 'dart:convert';
import 'package:bharat_safar/feaures/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bharat_safar/feaures/auth/domain/entities/user_entity.dart';
import 'package:bharat_safar/feaures/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  static const String _userSessionKey = 'CACHED_USER_SESSION';

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<UserEntity> signInWithGoogle() async {
    final userModel = await remoteDataSource.signInWithGoogle();
    await _saveLocalSession(userModel);
    return userModel;
  }

  @override
  Future<UserEntity> signInWithFacebook() async {
    final userModel = await remoteDataSource.signInWithFacebook();
    await _saveLocalSession(userModel);
    return userModel;
  }

  @override
  Future<UserEntity> signInWithEmail(String email) async {
    final userModel = await remoteDataSource.signInWithEmail(email);
    await _saveLocalSession(userModel);
    return userModel;
  }

  @override
  Future<UserEntity> signInWithMobile(String mobile) async {
    final userModel = await remoteDataSource.signInWithMobile(mobile);
    await _saveLocalSession(userModel);
    return userModel;
  }

  Future<void> _saveLocalSession(UserModel user) async {
    final String userJson = jsonEncode(user.toJson());
    await sharedPreferences.setString(_userSessionKey, userJson);
  }

  Future<UserEntity?> getSavedSession() async {
    final String? userJson = sharedPreferences.getString(_userSessionKey);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }

  Future<void> logout() async {
    await sharedPreferences.remove(_userSessionKey);
  }
}
