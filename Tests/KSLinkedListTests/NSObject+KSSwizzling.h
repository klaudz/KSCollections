//
//  NSObject+KSSwizzling.h
//  KSLinkedListTests
//
//  Created by klaudz on 2020/9/15.
//  Copyright © 2020 Klaudz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KSSwizzling)

+ (void)kst_swizzleInstanceMethodWithOriginalSelector:(SEL)originalSelector
                                     replacedSelector:(SEL)replacedSelector;

+ (void)kst_swizzleClassMethodWithOriginalSelector:(SEL)originalSelector
                                  replacedSelector:(SEL)replacedSelector;

@end

NS_ASSUME_NONNULL_END
