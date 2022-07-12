import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ContentViewState<T extends StatefulWidget> extends State<T> {
  DataResult? _dataResult;

  Future<void> _onDataLoad() async {
    setState(() => _dataResult = null);
    try {
      _dataResult = await onDataLoad();
    } catch (e) {
      _dataResult = DataResult.failed(error: e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<DataResult> onDataLoad();

  void retryDataLoad() => _onDataLoad();

  Widget buildLoading(BuildContext context) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget buildFailed(
    BuildContext context, {
    String? reason,
    required bool hasRetry,
  }) =>
      Scaffold(
        body: Center(
          child: Stack(
            children: [
              buildLoading(context),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(color: Colors.black.withOpacity(0)),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (reason?.isNotEmpty == true) Text(reason!),
                    if (hasRetry)
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: retryDataLoad,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget buildView(BuildContext context);

  @override
  void initState() {
    _onDataLoad();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataResult = _dataResult;

    if (dataResult == null) {
      return buildLoading(context);
    }

    if (!dataResult.success) {
      return buildFailed(
        context,
        reason: dataResult.reason,
        hasRetry: dataResult.hasRetry,
      );
    }

    return buildView(context);
  }
}

class DataResult {
  DataResult.success({this.hasRetry = true})
      : success = true,
        error = null,
        reason = null;

  DataResult.failed({
    this.error,
    this.reason,
    this.hasRetry = true,
  }) : success = false;

  final bool success;

  final bool hasRetry;

  final Object? error;

  final String? reason;
}
