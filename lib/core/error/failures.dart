import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.properties = const <dynamic>[]});

  final List properties;

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {
  final String error;
  const ServerFailure({required this.error});
}

class ApiFailure extends Failure {
  final String error;
  const ApiFailure({required this.error});
}

class CacheFailure extends Failure {}

class InternalFailure extends Failure {
  final String error;
  const InternalFailure({required this.error});
}
