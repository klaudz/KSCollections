//
//  KSLinkedNode.m
//  KSLinkedList
//
//  Created by klaudz on 2020/9/13.
//

#import "KSLinkedNode.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KSLinkedNode

- (void)dealloc
{
    [_object release];
    [_prevNode release];
    [_nextNode release];
    
    [super dealloc];
}

@end

NS_ASSUME_NONNULL_END
