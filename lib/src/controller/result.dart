sealed class ApiResponse<S, E extends Exception> {
  const ApiResponse();
}

final class Success<S, E extends Exception> extends ApiResponse<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends ApiResponse<S, E> {
  const Failure(this.exception);
  final E exception;
}
