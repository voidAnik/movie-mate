import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../error/failures.dart';
import 'common_api_state.dart';

class CommonApiCubit<T> extends Cubit<CommonApiState> {
  CommonApiCubit() : super(ApiInitial());

  Future<void> performApiCall(Future<Either<Failure, T>> Function() apiCall,
      {Function(T)? successAction}) async {
    emit(ApiLoading());
    final Either<Failure, T> failureOrResponse = await apiCall();

    failureOrResponse.fold((failure) {
      log(
        'Api call failure: ${failure}',
      );
      if (failure is ServerFailure) {
        emit(ApiError(message: failure.error));
      } else {
        emit(const ApiError(message: 'Unknown Exception'));
      }
    }, (response) {
      if (successAction != null) {
        successAction(response);
      }
      emit(ApiSuccess<T>(response: response));
    });
  }
}
