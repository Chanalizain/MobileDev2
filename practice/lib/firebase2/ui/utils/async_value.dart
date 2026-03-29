enum AsyncValueState { loading, error, success }

class AsyncValue<T> {
  final T? data;
  final Object? error;
  final AsyncValueState state;
  final bool isLoading;

  AsyncValue._({this.data, this.error, required this.state, this.isLoading = false,
  });

  factory AsyncValue.loading() => AsyncValue._(state: AsyncValueState.loading);

  factory AsyncValue.success(T data) =>
      AsyncValue._(data: data, state: AsyncValueState.success);

  factory AsyncValue.error(Object error) =>
      AsyncValue._(error: error, state: AsyncValueState.error);
  
  R when<R>({
    required R Function() loading,
    required R Function(Object error) error,
    required R Function(T data) success,
  }) {
    if (isLoading) {
      return loading();
    }
    if (this.error != null) {
      return error(this.error!);
    }
    // If we are here, we know data is not null and is of type T
    return success(data as T);
  }
}
