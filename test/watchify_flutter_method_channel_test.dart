import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watchify_flutter/watchify_flutter_method_channel.dart';

void main() {
  MethodChannelWatchifyFlutter platform = MethodChannelWatchifyFlutter();
  const MethodChannel channel = MethodChannel('watchify_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
