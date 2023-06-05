// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'privacy_bloc.dart';

class PrivacyState extends Equatable {
  const PrivacyState({
    required this.privacy,
  });

  final String privacy;

  const PrivacyState.initial() : privacy = '';

  PrivacyState copyWith({
    String? privacy,
  }) {
    return PrivacyState(
      privacy: privacy ?? '',
    );
  }

  @override
  List<Object> get props => [privacy];

  @override
  String toString() {
    return '$runtimeType(${privacy.toString()})';
  }
}
