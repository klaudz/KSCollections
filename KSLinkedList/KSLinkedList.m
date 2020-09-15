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
    node.prevNode = self.tailNode;
    if (self.tailNode) {
        self.tailNode.nextNode = node;
    } else {
        self.headNode = node;
    }
    self.tailNode = node;
    self.count++;
}

- (void)insertHeadNode:(KSLinkedNode *)node
{
    if (node.linkedList == self) {
        [self removeNode:node];
    }
    NSAssert(node.linkedList == nil, ([NSString stringWithFormat:@"Node %@ was referred to another linked list", node]));
    
    node.linkedList = self;
    node.prevNode = nil;
    node.nextNode = self.headNode;
    if (self.headNode) {
        self.headNode.prevNode = node;
    } else {
        self.tailNode = node;
    }
    self.headNode = node;
    self.count++;
}

- (void)insertNode:(KSLinkedNode *)node atIndex:(NSUInteger)index
{
    if (node.linkedList == self) {
        [self removeNode:node];
    }
    NSAssert(node.linkedList == nil, ([NSString stringWithFormat:@"Node %@ was referred to another linked list", node]));
    NSAssert(index <= self.count,
             ([NSString stringWithFormat:@"Index %llu beyond bounds %@",
               (unsigned long long)index,
               (self.count > 0) ? [NSString stringWithFormat:@"[0 .. %llu]", (unsigned long long)(self.count - 1)] : @"for empty linked list"]));
    
    KSLinkedNode *targetNode = nil;
    for (NSUInteger i = 0; i < index; i++) {
        if (targetNode == nil) {
            targetNode = self.headNode;
        } else if (targetNode.nextNode) {
            targetNode = targetNode.nextNode;
        } else {
            // Beyond bounds
        }
    }
    if (targetNode) {
        [self insertNode:node afterNode:targetNode];
    } else {
        // Insert node as the head node
        [self insertHeadNode:node];
    }
}

- (void)insertNode:(KSLinkedNode *)node afterNode:(KSLinkedNode *)siblingNode
{
    NSAssert(siblingNode.linkedList == self, ([NSString stringWithFormat:@"Node %@ was not referred to this linked list", node]));
    if (node.linkedList == self) {
        [self removeNode:node];
    }
    NSAssert(node.linkedList == nil, ([NSString stringWithFormat:@"Node %@ was referred to another linked list", node]));
    
    node.linkedList = self;
    siblingNode.nextNode.prevNode = node;
    node.nextNode = siblingNode.nextNode;
    siblingNode.nextNode = node;
    node.prevNode = siblingNode;
    if (self.tailNode == siblingNode) {
        self.tailNode = node;
    }
    self.count++;
}

- (void)insertNode:(KSLinkedNode *)node beforeNode:(KSLinkedNode *)siblingNode
{
    NSAssert(siblingNode.linkedList == self, ([NSString stringWithFormat:@"Node %@ was not referred to this linked list", node]));
    if (node.linkedList == self) {
        [self removeNode:node];
    }
    NSAssert(node.linkedList == nil, ([NSString stringWithFormat:@"Node %@ was referred to another linked list", node]));
    
    node.linkedList = self;
    siblingNode.prevNode.nextNode = node;
    node.prevNode = siblingNode.prevNode;
    siblingNode.prevNode = node;
    node.nextNode = siblingNode;
    if (self.headNode == siblingNode) {
        self.headNode = node;
    }
    self.count++;
}

#pragma mark Remove Nodes

- (void)removeNode:(KSLinkedNode *)node
{
    if (node.linkedList != self) {
        return;
    }
    
    [node retain];
    
    if (self.headNode == node) self.headNode = node.nextNode;
    if (self.tailNode == node) self.tailNode = node.prevNode;
    if (node.prevNode) node.prevNode.nextNode = node.nextNode;
    if (node.nextNode) node.nextNode.prevNode = node.prevNode;
    
    node.prevNode = nil;
    node.nextNode = nil;
    node.linkedList = nil;
    self.count--;
    
    [node release];
}

- (void)removeAllNodes
{
    if (self.headNode == nil || self.tailNode == nil) {
        return;
    }
    
    KSLinkedNode *node = self.headNode;
    while (node) {
        KSLinkedNode *nextNode = node.nextNode;
        node.prevNode = nil;
        node.nextNode = nil;
        node.linkedList = nil;
        node = nextNode;
    }
    self.headNode = nil;
    self.tailNode = nil;
    self.count = 0;
}

- (void)removeNodesFromNode:(KSLinkedNode *)fromNode toNode:(KSLinkedNode *)toNode
{
    NSAssert(fromNode.linkedList == self, ([NSString stringWithFormat:@"Node %@ was not referred to this linked list", fromNode]));
    NSAssert(toNode.linkedList == self, ([NSString stringWithFormat:@"Node %@ was not referred to this linked list", toNode]));
    
    [fromNode retain];
    [toNode retain];
    
    if (self.headNode == fromNode) self.headNode = toNode.nextNode;
    if (self.tailNode == toNode) self.tailNode = fromNode.prevNode;
    if (fromNode.prevNode) fromNode.prevNode.nextNode = toNode.nextNode;
    if (toNode.nextNode) toNode.nextNode.prevNode = fromNode.prevNode;
    
    NSUInteger removedCount = 0;
    KSLinkedNode *node = fromNode;
    while (node) {
        KSLinkedNode *nextNode = (node != toNode) ? node.nextNode : nil;
        node.prevNode = nil;
        node.nextNode = nil;
        node.linkedList = nil;
        removedCount++;
        node = nextNode;
    }
    self.count -= removedCount;
    
    [fromNode release];
    [toNode release];
}

- (void)removeNodesFromNode:(KSLinkedNode *)fromNode
{
    if (self.tailNode == nil) {
        return;
    }
    [self removeNodesFromNode:fromNode toNode:self.tailNode];
}

- (void)removeNodesAfterNode:(KSLinkedNode *)afterNode
{
    if (self.tailNode == nil || afterNode.nextNode == nil) {
        return;
    }
    [self removeNodesFromNode:afterNode.nextNode toNode:self.tailNode];
}

- (void)removeNodesToNode:(KSLinkedNode *)toNode
{
    if (self.headNode == nil) {
        return;
    }
    [self removeNodesFromNode:self.headNode toNode:toNode];
}

- (void)removeNodesBeforeNode:(KSLinkedNode *)beforeNode
{
    if (self.headNode == nil || beforeNode.prevNode == nil) {
        return;
    }
    [self removeNodesFromNode:self.headNode toNode:beforeNode.prevNode];
}

@end

NS_ASSUME_NONNULL_END
