import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:watchify_flutter/watchify_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final watchify = WatchifyFlutter();

  var counter = 0;

  bool isSupported = false;
  var isPaired = false;
  var isReachable = false;
  var contextFromApplication = <String, dynamic>{};
  var receivedApplicationContexts = <Map<String, dynamic>>[];
  List listView = <String>[];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    watchify
        .messageStream()
        .listen((e) => setState(() => listView.add('Received message: $e')));
    watchify
        .contextStream()
        .listen((e) => setState(() => listView.add('Received context: $e')));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await watchify.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    isSupported = await watchify.isSupported();
    isPaired = await watchify.isPaired();
    isReachable = await watchify.isReachable();
    contextFromApplication = await watchify.contextFromApplication();
    receivedApplicationContexts = await watchify.receivedApplicationContexts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Watchify Test App'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Text('Running on: $_platformVersion\n')
            Text('Supported: $isSupported'),
            Text('Paired: $isPaired'),
            Text('Reachable: $isReachable'),
            Text('Context: $contextFromApplication'),
            Text('Received contexts: $receivedApplicationContexts'),
            InkWell(
              child: const Text(
                'Refresh',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onTap: initPlatformState,
            ),
          ]),
        ),
      ),
    );
  }
}
