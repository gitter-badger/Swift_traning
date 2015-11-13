//
// Generated by CocoaPods-Keys
// on 27/10/2015
// For more information see https://github.com/orta/cocoapods-keys
//

#import <objc/runtime.h>
#import <Foundation/NSDictionary.h>
#import "SfpartiesKeys.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation SfpartiesKeys

#pragma clang diagnostic pop

+ (BOOL)resolveInstanceMethod:(SEL)name
{
  NSString *key = NSStringFromSelector(name);
  NSString * (*implementation)(SfpartiesKeys *, SEL) = NULL;

  if ([key isEqualToString:@"googleAnalytics"]) {
    implementation = _podKeys0e9897b56c8bc3b62f18b80f31b86bac;
  }

  if ([key isEqualToString:@"uber"]) {
    implementation = _podKeys92553f8122d8741804f476b3a9a1423d;
  }

  if ([key isEqualToString:@"mixpanel"]) {
    implementation = _podKeys435f4592acdcafa38ea5378f5b1d4d77;
  }

  if ([key isEqualToString:@"parseApplicationId"]) {
    implementation = _podKeysa8de356b4723a098354412f8d205af6c;
  }

  if ([key isEqualToString:@"parseClientKey"]) {
    implementation = _podKeys89ea18077626ea9c967643acff3abc36;
  }

  if (!implementation) {
    return [super resolveInstanceMethod:name];
  }

  return class_addMethod([self class], name, (IMP)implementation, "@@:");
}

static NSString *_podKeys0e9897b56c8bc3b62f18b80f31b86bac(SfpartiesKeys *self, SEL _cmd)
{
  
    
      char cString[2] = { SfpartiesKeysData[29], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}

static NSString *_podKeys92553f8122d8741804f476b3a9a1423d(SfpartiesKeys *self, SEL _cmd)
{
  
    
      char cString[2] = { SfpartiesKeysData[90], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}

static NSString *_podKeys435f4592acdcafa38ea5378f5b1d4d77(SfpartiesKeys *self, SEL _cmd)
{
  
    
      char cString[2] = { SfpartiesKeysData[68], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}

static NSString *_podKeysa8de356b4723a098354412f8d205af6c(SfpartiesKeys *self, SEL _cmd)
{
  
    
      char cString[2] = { SfpartiesKeysData[16], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}

static NSString *_podKeys89ea18077626ea9c967643acff3abc36(SfpartiesKeys *self, SEL _cmd)
{
  
    
      char cString[2] = { SfpartiesKeysData[133], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}


static char SfpartiesKeysData[142] = "ICRlS37Xg2qTZ4vnYkxinl5W4thozYtuS6jxTJeEy+dUlXnQb4Sw7NVkinWExk0nnZmfYW9UFaSELfu7EwvQn+tV6sYl5z6RDvB+goKth34IKU3LPnn3HmMIoUKmSf/UJXR2HYFlTErz\\\"";

- (NSString *)description
{
  return [@{
            @"googleAnalytics": self.googleAnalytics,
            @"uber": self.uber,
            @"mixpanel": self.mixpanel,
            @"parseApplicationId": self.parseApplicationId,
            @"parseClientKey": self.parseClientKey,
  } description];
}

- (id)debugQuickLookObject
{
  return [self description];
}

@end