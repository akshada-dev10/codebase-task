import 'dart:async';
import 'package:codebase_task/utils/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamProviderNotifier extends StateNotifier<Stream<int>> {
  StreamProviderNotifier() : super(_generateStream());

  static Stream<int> _generateStream() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield i;
    }
  }
}

final streamProvider =
StateNotifierProvider<StreamProviderNotifier, Stream<int>>(
        (ref) => StreamProviderNotifier());

class MyStreamScreen extends ConsumerStatefulWidget {
  @override
  _MyStreamScreenState createState() => _MyStreamScreenState();
}

class _MyStreamScreenState extends ConsumerState<MyStreamScreen> {
  @override
  Widget build(BuildContext context) {
    final stream = ref.watch(streamProvider);

    return Scaffold(
      appBar: AppBar(title: Text("AppStreamBuilder with Riverpod")),
      body: Center(
        child: AppStreamBuilder<int>(
          stream: stream,
          initialData: 0,
          onData: (data) => print("Received: $data"),
          busyBuilder: (context) => CircularProgressIndicator(),
          errorBuilder: (context, error) => Text("Error: $error"),
          dataBuilder: (context, data) => Text(
            "Current Value: $data",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
