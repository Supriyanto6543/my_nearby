import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message: message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(String message) : super(message: message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message: message);
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException({required this.message});
}
