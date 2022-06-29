#import "WatchifyFlutterPlugin.h"
#if __has_include(<watchify_flutter/watchify_flutter-Swift.h>)
#import <watchify_flutter/watchify_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "watchify_flutter-Swift.h"
#endif

@implementation WatchifyFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [WatchifyMe registerWithRegistrar:registrar];
}
@end
