//
//  KSLinkedList+Tests.h
//  KSLinkedListTests
//
//  Created by klaudz on 2020/9/15.
//  Copyright © 2020 Klaudz. All rights reserved.
//

#import "KSLinkedList.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSLinkedList (Tests)

@property (class, nonatomic, assign, readonly) NSInteger kst_aliveCount;

+ (void)kst_resetAliveCount;

@end

@interface KSLinkedNode (Tests)

@property (class, nonatomic, assign, readonly) NSInteger kst_aliveCount;

+ (void)kst_resetAliveCount;

@end

NS_ASSUME_NONNULL_END
