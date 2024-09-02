import 'package:dartz/dartz.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';

class ReturnFailure<T> {
  Future<Either<Failure, T>> call(Exception e) async {
    if (e is ServerException) {
      return const Left(
          ServerFailure(error: 'SERVER FAILURE'));
    } else if (e is ApiException) {
      return  Left(
          ApiFailure(error: e.error));
    } else if (e is CacheException){
      return Left(CacheFailure());
    } else {
      return const Left(InternalFailure(error: 'INTERNAL FAILURE'));
    }
  }
}
