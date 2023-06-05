// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.connectionId,
    required this.state,
  });

  final String connectionId;

  // Státusz, lehet NULL is...
  final ApiState<void>? state;

  SettingsState copyWith({
    String? connectionId,
    ApiState<void>? state,
  }) {
    return SettingsState(
      connectionId: connectionId ?? this.connectionId,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [connectionId, state];

  @override
  bool get stringify => true;
}
