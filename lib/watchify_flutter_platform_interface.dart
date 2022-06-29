import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'watchify_flutter_method_channel.dart';

abstract class WatchifyFlutterPlatform extends PlatformInterface {
  /// Constructs a WatchifyFlutterPlatform.
  WatchifyFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WatchifyFlutterPlatform _instance = MethodChannelWatchifyFlutter();

  /// The default instance of [WatchifyFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWatchifyFlutter].
  static WatchifyFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WatchifyFlutterPlatform] when
  /// they register themselves.
  static set instance(WatchifyFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> isSupported() {
    throw UnimplementedError('is not supported right now');
  }

  Future<bool> isPaired() {
    throw UnimplementedError('is not supported right now');
  }

  Future<bool> isReachable() {
    throw UnimplementedError('is not supported right now');
  }

  Future<Map<String, dynamic>> contextFromApplication() {
    throw UnimplementedError('is not supported right now');
  }

  Future<List<Map<String, dynamic>>> receivedApplicationContexts() {
    throw UnimplementedError('is not supported right now');
  }
  Future<void> updateApplicationContext(Map<String, dynamic> context) {
    throw UnimplementedError('check format');
  }
  Future<void> sendMessage(Map<String, dynamic> message) {
    throw UnimplementedError('check format');
  }


  Stream<Map<String, dynamic>> messageStream() {
    throw UnimplementedError('Stream Failed');
  }
   Stream<Map<String, dynamic>> contextStream() {
    throw UnimplementedError('Stream failed');
  }
}
