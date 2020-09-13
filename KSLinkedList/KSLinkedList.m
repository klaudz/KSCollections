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

#pragma mark Insert Nodes

- (void)addNode:(KSLinkedNode *)node
{
    if (self.tailNode == nil) {
        self.headNode = node;
        self.tailNode = node;
    } else {
        self.tailNode.nextNode = node;
        node.prevNode = self.tailNode;
        self.tailNode = node;
    }
    self.count++;
}

@end

NS_ASSUME_NONNULL_END
