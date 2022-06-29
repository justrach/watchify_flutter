import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'watchify_flutter_platform_interface.dart';

/// An implementation of [WatchifyFlutterPlatform] that uses method channels.
class MethodChannelWatchifyFlutter extends WatchifyFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('watchify_flutter');


    //  static const methodChannel = const MethodChannel('watchify_flutter');
  
        @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
    Future<bool> isSupported() async {
    final supported = await methodChannel.invokeMethod<bool>('isSupported');
    return supported ?? false;
  }

  @override
  Future<bool>  isPaired() async {
    final paired = await methodChannel.invokeMethod<bool>('isPaired');
    return paired ?? false;
  }

  @override
  Future<bool> isReachable() async {
    final reachable = await methodChannel.invokeMethod<bool>('isReachable');
    return reachable ?? false;
  }

  /// The most recently sent contextual data
  @override
  Future<Map<String, dynamic>> contextFromApplication() async {
    final applicationContext =
        await methodChannel.invokeMapMethod<String, dynamic>('applicationContext');
    return applicationContext ?? {};
  }
@override
//convert to mode, from dictionary upon getting item
  Future<List<Map<String, dynamic>>>  receivedApplicationContexts() async {
    final receivedApplicationContexts =
        await methodChannel.invokeListMethod('receivedApplicationContexts');
    final transformedContexts = receivedApplicationContexts
        ?.map((e) => Map<String, dynamic>.from(e))
        .toList();
    return transformedContexts ?? [];
  }
  //message string, can be deconstructed with a simple deconstructor
  @override
  Future<void> sendMessage(Map<String, dynamic> message) {
    return methodChannel.invokeMethod('sendMessage', message);
  }

  /// Update the application context
  Future<void> updateApplicationContext(
    Map<String, dynamic> context,
  ) {
    return methodChannel.invokeMethod('updateApplicationContext', context);
  }
   MethodChannelWatchifyFlutter() {
    methodChannel.setMethodCallHandler(_handle);
  }
final _messageControllerHandler =
      StreamController<Map<String, dynamic>>.broadcast();
  final _contextControllerHandler =
      StreamController<Map<String, dynamic>>.broadcast();
      //   Stream<> get messageStream =>
      // _messageControllerHandler.stream;
      @override
  Stream<Map<String, dynamic>>  messageStream() =>
      _messageControllerHandler.stream;
      @override
  Stream<Map<String, dynamic>>  contextStream() =>
      _contextControllerHandler.stream;
    Future _handle(MethodCall call) async {
    switch (call.method) {
      case 'didReceiveMessage':
        _messageControllerHandler.add(Map<String, dynamic>.from(call.arguments));
        break;
      case 'didReceiveApplicationContext':
        _contextControllerHandler.add(Map<String, dynamic>.from(call.arguments));
        break;
      default:
        throw UnimplementedError('${call.method} not implemented'); //replicate Swift switches
    }
  }
}
