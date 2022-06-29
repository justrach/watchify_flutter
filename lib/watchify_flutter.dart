import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:watchify_flutter/watchify_flutter_method_channel.dart';

import 'watchify_flutter_platform_interface.dart';

class WatchifyFlutter {
  Future<String?> getPlatformVersion() {
    return WatchifyFlutterPlatform.instance.getPlatformVersion();
  }

  Future<bool> isReachable() {
    return WatchifyFlutterPlatform.instance.isReachable();
  }

  Future<bool> isPaired() {
    return WatchifyFlutterPlatform.instance.isReachable();
  }

  Future<bool> isSupported() {
    return WatchifyFlutterPlatform.instance.isReachable();
  }

  Future<Map<String, dynamic>> contextFromApplication() {
    return WatchifyFlutterPlatform.instance.contextFromApplication();
  }

//to check for updates on this stream, add a listen method!
  Future<List<Map<String, dynamic>>> receivedApplicationContexts() {
    return WatchifyFlutterPlatform.instance.receivedApplicationContexts();
  }

  Stream<Map<String, dynamic>> messageStream() {
    return WatchifyFlutterPlatform.instance.messageStream();
  }

Future<void> updateApplicationContext(Map<String, dynamic> message) {
    return WatchifyFlutterPlatform.instance.sendMessage(message);
  }
  Future<void> sendMessage(Map<String, dynamic> message) {
    return WatchifyFlutterPlatform.instance.sendMessage(message);
  }
   Stream<Map<String, dynamic>> contextStream() {
    return WatchifyFlutterPlatform.instance.contextStream();
  }

//change the type of return you want in the SwiftUI code for the watch!
static Future<int> contextIntegerReturn() async {
    final response = await WatchifyFlutterPlatform.instance.receivedApplicationContexts();
    var encodedResponse = jsonEncode(response[0]);
    // print(respite.runtimeType);
    Map<String, dynamic> d = json.decode(encodedResponse);
    // print("value eof d is ");
    print(d['packet']);

    return d['packet'];
  }
  static Future<String> contextStringReturn() async {
    final response = await WatchifyFlutterPlatform.instance.receivedApplicationContexts();
    var encodedResponse = jsonEncode(response[0]);
    // print(respite.runtimeType);
    Map<String, dynamic> d = json.decode(encodedResponse);
    // print("value eof d is ");
    print(d['packet']);
    //

    return d['packet'];
  }
  //to add on listen method to let users change the item that thhey work with 
}
