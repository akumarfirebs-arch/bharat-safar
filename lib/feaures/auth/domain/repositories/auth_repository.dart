import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithGoogle();
  Future<UserEntity> signInWithFacebook();
  Future<UserEntity> signInWithMobile(String modile);
  Future<UserEntity> signInWithEmail(String email);
}
