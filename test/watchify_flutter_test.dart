import 'package:flutter_test/flutter_test.dart';
import 'package:watchify_flutter/watchify_flutter.dart';
import 'package:watchify_flutter/watchify_flutter_platform_interface.dart';
import 'package:watchify_flutter/watchify_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWatchifyFlutterPlatform 
    with MockPlatformInterfaceMixin
    implements WatchifyFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WatchifyFlutterPlatform initialPlatform = WatchifyFlutterPlatform.instance;

  test('$MethodChannelWatchifyFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWatchifyFlutter>());
  });

  test('getPlatformVersion', () async {
    WatchifyFlutter watchifyFlutterPlugin = WatchifyFlutter();
    MockWatchifyFlutterPlatform fakePlatform = MockWatchifyFlutterPlatform();
    WatchifyFlutterPlatform.instance = fakePlatform;
  
    expect(await watchifyFlutterPlugin.getPlatformVersion(), '42');
  });
}
