#import "EzValidatorPlugin.h"
#if __has_include(<ez_validator/ez_validator-Swift.h>)
#import <ez_validator/ez_validator-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ez_validator-Swift.h"
#endif

@implementation EzValidatorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEzValidatorPlugin registerWithRegistrar:registrar];
}
@end
