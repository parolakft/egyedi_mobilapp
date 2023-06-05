// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'navigation_bloc.dart';

/// Navigációs állapotok, jelen esetben a megjelenő oldalakat reprezentálja
abstract class NavigationState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

/*
/
 */
class SplashNavigationState extends NavigationState {}

/*
/error/:errMsg
 */
class ErrorNavigationState extends NavigationState {
  final ErrorState errorState;
  final Exception? error;

  ErrorNavigationState(this.errorState, [this.error]);

  @override
  List<Object?> get props => [errorState, error];
}

/*
/login
 */
class LoginNavigationState extends NavigationState {}

/*
/login/registration
 */
class RegistrationNavigationState extends LoginNavigationState {}

/*
/login/forgotten pw
 */
class ForgottenPwNavigationState extends LoginNavigationState {}

abstract class AuthenticatedNavigationState extends NavigationState {
  AuthenticatedNavigationState({
    required this.user,
  });

  final User user;

  @override
  List<Object> get props => [user];
}

/*
/category
 */
class CategoryNavigationState extends AuthenticatedNavigationState {
  CategoryNavigationState._({
    required User user,
  }) : super(user: user);

  CategoryNavigationState.initial({
    required User user,
  }) : this._(
          user: user,
        );

  CategoryNavigationState.copy({
    required CategoryNavigationState state,
  }) : this._(
          user: state.user,
        );

  @override
  List<Object> get props => [...super.props];
}

/*
/category/item
 */
class ItemDetailsNavigationState extends CategoryNavigationState {
  ItemDetailsNavigationState.copyFromBase({
    required CategoryNavigationState state,
    required this.item,
  }) : super.copy(state: state);

  final ItemTile item;

  ItemDetailsNavigationState.copy({
    required CategoryNavigationState state,
    required this.item,
  }) : super.copy(state: state);

  @override
  List<Object> get props => [...super.props];
}

/*
/category/profile
 */
class ProfileNavigationState extends CategoryNavigationState {
  ProfileNavigationState.copyFromBase({
    required CategoryNavigationState state,
  }) : super.copy(state: state);

  ProfileNavigationState.copy({
    required CategoryNavigationState state,
  }) : super.copy(state: state);

  @override
  List<Object> get props => [...super.props];
}
