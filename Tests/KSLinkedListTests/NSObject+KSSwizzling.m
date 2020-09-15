//
//  NSObject+KSSwizzling.m
//  KSLinkedListTests
//
//  Created by klaudz on 2020/9/15.
//  Copyright © 2020 Klaudz. All rights reserved.
//

#import "NSObject+KSSwizzling.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (KSSwizzling)

+ (void)kst_swizzleInstanceMethodWithOriginalSelector:(SEL)originalSelector
                                     replacedSelector:(SEL)replacedSelector
{
    Class class = self;
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method replacedMethod = class_getInstanceMethod(self, replacedSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (didAddMethod) {
        class_replaceMethod(class, replacedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, replacedMethod);
    }
}

+ (void)kst_swizzleClassMethodWithOriginalSelector:(SEL)originalSelector
                                  replacedSelector:(SEL)replacedSelector
{
    Class class = object_getClass(self);
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method replacedMethod = class_getClassMethod(class, replacedSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (didAddMethod) {
        class_replaceMethod(class, replacedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, replacedMethod);
    }
}

@end

NS_ASSUME_NONNULL_END
