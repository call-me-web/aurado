import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import 'network_info.dart';

/// Base repository with built-in network checking and error handling.
///
/// Features using repositories should extend this to avoid boilerplate.
abstract class BaseRepository {
  const BaseRepository(this.networkInfo);

  final NetworkInfo networkInfo;

  /// Wraps a remote call with network check and standard error handling.
  Future<Either<AppFailure, T>> call<T>(Future<T> Function() remoteCall) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final result = await remoteCall();
      return Right(result);
    } on AppFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred.', cause: e));
    }
  }
}
