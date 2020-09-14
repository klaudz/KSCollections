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

- (instancetype)initWithArray:(NSArray *)array
{
    self = [self init];
    if (self) {
        for (id object in array) {
            KSLinkedNode *node = [[KSLinkedNode alloc] initWithObject:object];
            [self addNode:node];
            [node release];
        }
    }
    return self;
}

+ (instancetype)listWithArray:(NSArray *)array
{
    return [[[self alloc] initWithArray:array] autorelease];
}

- (void)dealloc
{
    // TODO: Remove all nodes and clean up their referred `.linkedList`
    
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
    if (node.linkedList == self) {
        [self removeNode:node];
    }
    NSAssert(node.linkedList == nil, ([NSString stringWithFormat:@"Node %@ was referred to another linked list", node]));
    
    node.linkedList = self;
    node.nextNode = nil;
    if (self.tailNode == nil) {
        node.prevNode = nil;
        self.headNode = node;
        self.tailNode = node;
    } else {
        node.prevNode = self.tailNode;
        self.tailNode.nextNode = node;
        self.tailNode = node;
    }
    self.count++;
}

#pragma mark Remove Nodes

- (void)removeNode:(KSLinkedNode *)node
{
    if (node.linkedList != self) {
        return;
    }
    
    if (self.headNode == node) self.headNode = node.nextNode;
    if (self.tailNode == node) self.tailNode = node.prevNode;
    if (node.prevNode) node.prevNode.nextNode = node.nextNode;
    if (node.nextNode) node.nextNode.prevNode = node.prevNode;
    node.prevNode = nil;
    node.nextNode = nil;
    node.linkedList = nil;
    self.count--;
}

@end

NS_ASSUME_NONNULL_END
