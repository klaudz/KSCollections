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

#pragma mark Enumerate Nodes

- (void)enumerateNodesUsingBlock:(void (^)(KSLinkedNode *node, NSUInteger index, BOOL *stop))block
{
    [self enumerateNodesWithOptions:kNilOptions usingBlock:block];
}

- (void)enumerateNodesWithOptions:(NSEnumerationOptions)options usingBlock:(void (^)(KSLinkedNode *node, NSUInteger index, BOOL *stop))block;
{
    if ((options & NSEnumerationReverse) != NSEnumerationReverse) {
        KSLinkedNode *node = self.headNode;
        NSUInteger index = 0;
        BOOL stop = NO;
        while (node && !stop) {
            block(node, index, &stop);
            node = node.nextNode;
            index++;
        }
    } else {
        KSLinkedNode *node = self.tailNode;
        NSUInteger index = self.count - 1;
        BOOL stop = NO;
        while (node && !stop) {
            block(node, index, &stop);
            node = node.prevNode;
            index--;
        }
    }
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
