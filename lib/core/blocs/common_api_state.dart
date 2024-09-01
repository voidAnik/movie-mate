import 'package:equatable/equatable.dart';

abstract class CommonApiState extends Equatable {
  final List _props;

  const CommonApiState([this._props = const <dynamic>[]]);

  @override
  List<Object> get props => [_props];
}

class ApiInitial extends CommonApiState {}

class ApiLoading extends CommonApiState {}

class ApiSuccess<T> extends CommonApiState {
  final T response;

  const ApiSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response as Object];
}

class ApiError extends CommonApiState {
  final String message;

  const ApiError({required this.message});

  @override
  List<Object> get props => [message];
}
