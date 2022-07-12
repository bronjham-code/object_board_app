class ClientResult<T> {
  final bool success;

  final T? value;

  final Object? error;

  ClientResult.success(this.value)
      : success = true,
        error = null;

  ClientResult.failed(this.error)
      : success = false,
        value = null;
}
