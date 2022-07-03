import 'dart:async';

import 'package:get_it/get_it.dart';

extension GetItExtensions on GetIt {
  FutureOr safeUnregister<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(T)? disposingFunction,
  }) {
    try {
      isRegistered(
        instance: instance,
        instanceName: instanceName,
      );
    } catch (_) {
      return () {};
    }

    return unregister<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }
}
