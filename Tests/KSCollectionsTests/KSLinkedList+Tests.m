//
//  KSLinkedList+Tests.m
//  KSCollectionsTests
//
//  Created by klaudz on 2020/9/15.
//  Copyright © 2020 Klaudz. All rights reserved.
//

#import "KSLinkedList+Tests.h"
#import "NSObject+KSSwizzling.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - KSLinkedList

NSInteger KST_KSLinkedList_AliveCount = 0;

@implementation KSLinkedList (Tests)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self kst_swizzleClassMethodWithOriginalSelector:@selector(alloc) replacedSelector:@selector(kst_alloc)];
        [self kst_swizzleInstanceMethodWithOriginalSelector:NSSelectorFromString(@"dealloc") replacedSelector:@selector(kst_dealloc)];
    });
}

+ (instancetype)kst_alloc
{
    KST_KSLinkedList_AliveCount++;
    return [self kst_alloc];
}

- (void)kst_dealloc
{
    KST_KSLinkedList_AliveCount--;
    [self kst_dealloc];
}

+ (NSInteger)kst_aliveCount
{
    return KST_KSLinkedList_AliveCount;
}

+ (void)kst_resetAliveCount
{
    KST_KSLinkedList_AliveCount = 0;
}

@end

#pragma mark - KSLinkedNode

NSInteger KST_KSLinkedNode_AliveCount = 0;

@implementation KSLinkedNode (Tests)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self kst_swizzleClassMethodWithOriginalSelector:@selector(alloc) replacedSelector:@selector(kst_alloc)];
        [self kst_swizzleInstanceMethodWithOriginalSelector:NSSelectorFromString(@"dealloc") replacedSelector:@selector(kst_dealloc)];
    });
}

+ (instancetype)kst_alloc
{
    KST_KSLinkedNode_AliveCount++;
    return [self kst_alloc];
}

- (void)kst_dealloc
{
    KST_KSLinkedNode_AliveCount--;
    [self kst_dealloc];
}

+ (NSInteger)kst_aliveCount
{
    return KST_KSLinkedNode_AliveCount;
}

+ (void)kst_resetAliveCount
{
    KST_KSLinkedNode_AliveCount = 0;
}

@end

NS_ASSUME_NONNULL_END
