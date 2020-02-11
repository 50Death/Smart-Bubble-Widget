#import "SmartBubblePlugin.h"
#if __has_include(<smart_bubble/smart_bubble-Swift.h>)
#import <smart_bubble/smart_bubble-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "smart_bubble-Swift.h"
#endif

@implementation SmartBubblePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSmartBubblePlugin registerWithRegistrar:registrar];
}
@end
