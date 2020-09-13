//
//  KSLinkedList.m
//  KSLinkedList
//
//  Created by klaudz on 2020/9/14.
//

#import "KSLinkedList.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KSLinkedList

- (instancetype)init
{
    self = [super init];
    if (self) {
        _count = 0;
    }
    return self;
}

- (void)dealloc
{
    [_headNode release];
    [_tailNode release];
    
    [super dealloc];
}

@end

NS_ASSUME_NONNULL_END
