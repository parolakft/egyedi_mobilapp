// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'info_bloc.dart';

class InfoState extends Equatable {
  const InfoState({
    required this.info,
  });

  final String info;

  const InfoState.initial() : info = '';

  InfoState copyWith({
    String? info,
  }) {
    return InfoState(
      info: info ?? '',
    );
  }

  @override
  List<Object> get props => [info];

  @override
  String toString() {
    return '$runtimeType(${info.toString()})';
  }
}
