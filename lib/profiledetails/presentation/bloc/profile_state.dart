// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.user,
    required this.allergensList,
  });

  final User user;
  final List allergensList;

  const ProfileState.initial(this.user, this.allergensList);

  ProfileState copyWith({User? user, List? allergensList}) {
    return ProfileState(
      user: user ?? this.user,
      allergensList: allergensList ?? this.allergensList,
    );
  }

  @override
  List<Object> get props => [user, allergensList];

  @override
  String toString() {
    return '$runtimeType(${user.toString()}, ${allergensList.toString()})';
  }
}
