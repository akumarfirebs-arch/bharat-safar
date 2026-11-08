import 'package:bharat_safar/feaures/auth/domain/entities/user_entity.dart';
import 'package:bharat_safar/feaures/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<GoogleSignInRequested>(_onGoogleSignIn);
    on<FacebookSignInRequested>(_onFacebookSignIn);
    on<EmailSignInRequested>(_onEmailSignIn);
    on<MobileInRequested>(_onMobileSignIn);
  }

  Future<void> _onGoogleSignIn(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithGoogle();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onFacebookSignIn(
    FacebookSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithFacebook();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onEmailSignIn(
    EmailSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (event.email.isEmpty || !event.email.contains('@')) {
      emit(const AuthFailure("Please enter a valid email address."));
      return;
    }
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithEmail(event.email);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onMobileSignIn(
    MobileInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithMobile(event.mobile);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
