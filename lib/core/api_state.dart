// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';

enum ApiStatus { initial, loading, success, failure }

extension BooleanStatus on ApiStatus {
  bool get isInitial => this == ApiStatus.initial;
  bool get isLoading => this == ApiStatus.loading;
  bool get isSuccess => this == ApiStatus.success;
  bool get isFailure => this == ApiStatus.failure;
}

class ApiState<T> extends Equatable {
  final ApiStatus status;
  final T? data;
  final Exception? error;

  const ApiState({this.status = ApiStatus.initial, this.data, this.error});
  const ApiState.loading()
      : status = ApiStatus.loading,
        data = null,
        error = null;
  const ApiState.success(this.data)
      : status = ApiStatus.success,
        error = null;
  const ApiState.failure(this.error)
      : status = ApiStatus.failure,
        data = null;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data, error];

  ApiState<T> copyWith({
    ApiStatus? status,
    T? data,
    Exception? error,
  }) {
    return ApiState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
