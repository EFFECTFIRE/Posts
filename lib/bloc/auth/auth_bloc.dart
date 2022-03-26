import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/models/post_repo.dart';
import 'package:flutter_infinite_list/models/registration/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(status: AuthStatus.unauthorized)) {
    on<SignInEvent>(_signInMap);
    on<SignUpEvent>(_signUpMap);
    on<SignOutEvent>(_signOutMap);
    on<ChangeNameEvent>(_changeNameMap);
  }
  final PostRepository _postRepo = PostRepository();

  Future<void> _signInMap(SignInEvent event, Emitter<AuthState> emit) async {
    final signInOrFailure =
        await _postRepo.authFacade.signIn(event.email, event.password);
    signInOrFailure.fold(
        (authFailure) => emit(
            AuthState(status: AuthStatus.failure, authFailure: authFailure)),
        (r) => emit(AuthState(status: AuthStatus.authorized)));
  }

  Future<void> _signUpMap(SignUpEvent event, Emitter<AuthState> emit) async {
    final signUpOrFailure = await _postRepo.authFacade
        .signUp(event.email, event.password, event.displayName);
    signUpOrFailure.fold(
        (authFailure) => emit(
            AuthState(status: AuthStatus.failure, authFailure: authFailure)),
        (r) => emit(AuthState(status: AuthStatus.registred)));
  }

  Future<void> _signOutMap(SignOutEvent event, Emitter<AuthState> emit) async {
    final signOutOrFailure = await _postRepo.authFacade.signOut();
    signOutOrFailure.fold(
        (authfailure) => emit(
            AuthState(status: AuthStatus.registred, authFailure: authfailure)),
        (r) => emit(AuthState(status: AuthStatus.unauthorized)));
  }

  Future<void> _changeNameMap(
      ChangeNameEvent event, Emitter<AuthState> emit) async {
    final changedNameOrFailure =
        await _postRepo.authFacade.changeName(event.displayName);
    changedNameOrFailure.fold(
        (authfailure) => emit(
            AuthState(status: AuthStatus.authorized, authFailure: authfailure)),
        (r) => emit(AuthState(status: AuthStatus.authorized)));
  }
}
