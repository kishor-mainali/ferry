import 'package:gql_exec/gql_exec.dart';

import 'package:ferry_exec/src/fetch_policy.dart';

abstract interface class OperationRequest<TData, TVars> {
  TVars get vars;

  Operation get operation;

  Request get execRequest;

  /// The unique identifier for this request.
  ///
  /// If the same [requestId] is passed to multiple [OperationRequest]s, it will be
  /// treated as a refetch of the same operation. If an [updateResult] callback is
  /// passed, the results will be merged according to the callback.
  String? get requestId;

  /// Optional function to update the result based on the previous result. Useful
  /// for pagination.
  TData? Function(TData? previousResult, TData? result)? get updateResult;

  /// The optimistic result, generally used when running a mutation
  TData? get optimisticResponse;

  /// The key that maps to a [UpdateCacheHandler], defined on the client
  String? get updateCacheHandlerKey;

  /// An arbitrary JSON object that can be used to pass data to the [UpdateCacheHandler]
  Map<String, dynamic>? get updateCacheHandlerContext;

  /// The [FetchPolicy] to be used when executing this operation
  FetchPolicy? get fetchPolicy;

  /// If set to `true`, this request will be automatically added to the request
  /// controller when the stream returned by `request()` is listened to
  bool get executeOnListen;

  /// Parses data into a concrete type for the given operation
  ///
  /// This is a simple wrapper on the static fromJson method on the generated class.
  TData? parseData(Map<String, dynamic> json);

  /// Serializes data into a JSON object
  /// This is a simple wrapper on the `toJson` method on the data class
  Map<String, dynamic> dataToJson(TData data);

  /// Serializes variables into a JSON object
  /// This is a simple wrapper on the `toJson` method on the variables class
  Map<String, dynamic> varsToJson();

  OperationRequest<TData, TVars> transformOperation(
      Operation Function(Operation) transform);
}
