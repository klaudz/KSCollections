//
//  KSLinkedListTests.m
//  KSLinkedListTests
//
//  Created by klaudz on 2020/9/13.
//  Copyright © 2020 Klaudz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSLinkedList.h"

@interface KSLinkedListTests : XCTestCase

@end

@implementation KSLinkedListTests

- (void)setUp
{
    
}

- (void)tearDown
{
    
}

#pragma mark Enumerate Nodes

- (void)test_enumerateNodesWithOptions$usingBlock$
{
    // Initialize test data
    NSArray<NSNumber *> *testDataArray = @[ @(0), @(1), @(2), @(3) ];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:testDataArray];
    
    // Run tests
    NSMutableArray<NSNumber *> *resultIndexArray = [[NSMutableArray alloc] init];
    [linkedList enumerateNodesWithOptions:kNilOptions usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
        [resultIndexArray addObject:@(index)];
    }];
    
    // Assert results
    XCTAssert(testDataArray.count == resultIndexArray.count);
    for (NSUInteger i = 0; i < resultIndexArray.count; i++) {
        XCTAssert([testDataArray[i] isEqualToNumber:resultIndexArray[i]]);
    }
}

- (void)test_enumerateNodesWithOptions$usingBlock$_reverse
{
    // Initialize test data
    NSArray<NSNumber *> *testDataArray = @[ @(0), @(1), @(2), @(3) ];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:testDataArray];
    
    // Run tests
    NSMutableArray<NSNumber *> *resultIndexArray = [[NSMutableArray alloc] init];
    [linkedList enumerateNodesWithOptions:NSEnumerationReverse usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
        [resultIndexArray insertObject:@(index) atIndex:0];
    }];
    
    // Assert results
    XCTAssert(testDataArray.count == resultIndexArray.count);
    for (NSUInteger i = 0; i < resultIndexArray.count; i++) {
        XCTAssert([testDataArray[i] isEqualToNumber:resultIndexArray[i]]);
    }
}

#pragma mark Insert Nodes

- (void)test_addNode$
{
    // Initialize test data
    NSArray<NSNumber *> *testDataArray = @[ @(0), @(1), @(2), @(3) ];
    KSLinkedList *linkedList = [[KSLinkedList alloc] init];
    
    // Run tests
    for (NSNumber *number in testDataArray) {
        [linkedList addNode:[KSLinkedNode nodeWithObject:number]];
    }
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:testDataArray];
}

- (void)test_unshiftNode$
{
    // Initialize test data
    NSArray<NSNumber *> *testDataArray = @[ @(0), @(1), @(2), @(3) ];
    KSLinkedList *linkedList = [[KSLinkedList alloc] init];
    
    // Run tests
    for (NSNumber *number in [[testDataArray reverseObjectEnumerator] allObjects]) {
        [linkedList unshiftNode:[KSLinkedNode nodeWithObject:number]];
    }
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:testDataArray];
}

- (void)test_insertNode$atIndex$
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [[NSMutableArray alloc] init];
    KSLinkedList *linkedList = [[KSLinkedList alloc] init];
    KSLinkedNode *node0 = [KSLinkedNode nodeWithObject:@(0)];
    KSLinkedNode *node1 = [KSLinkedNode nodeWithObject:@(1)];
    KSLinkedNode *node2 = [KSLinkedNode nodeWithObject:@(2)];
    KSLinkedNode *node3 = [KSLinkedNode nodeWithObject:@(3)];
    
    // Run tests: insert the first node
    [linkedList insertNode:node1 atIndex:0];
    [mutableDataArray insertObject:node1.object atIndex:0];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: insert the node at the head
    [linkedList insertNode:node0 atIndex:0];
    [mutableDataArray insertObject:node0.object atIndex:0];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: insert the node at the tail
    [linkedList insertNode:node3 atIndex:2];
    [mutableDataArray insertObject:node3.object atIndex:2];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: insert the node in the middle
    [linkedList insertNode:node2 atIndex:2];
    [mutableDataArray insertObject:node2.object atIndex:2];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}

- (void)test_insertNode$afterNode$
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [@[ @(0) ] mutableCopy];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:mutableDataArray];
    KSLinkedNode *node1 = [KSLinkedNode nodeWithObject:@(1)];
    KSLinkedNode *node2 = [KSLinkedNode nodeWithObject:@(2)];
    KSLinkedNode *node3 = [KSLinkedNode nodeWithObject:@(3)];
    
    // Run tests: insert the node after the head and at the tail
    [linkedList insertNode:node2 afterNode:linkedList.headNode];
    [mutableDataArray insertObject:node2.object atIndex:1];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: insert the node after the head and in the middle
    [linkedList insertNode:node1 afterNode:linkedList.headNode];
    [mutableDataArray insertObject:node1.object atIndex:1];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: insert the node after a node and at the tail
    [linkedList insertNode:node3 afterNode:node2];
    [mutableDataArray insertObject:node3.object atIndex:3];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}


#pragma mark Remove Nodes

- (void)test_removeNode$
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [@[ @(0), @(1), @(2), @(3) ] mutableCopy];
    KSLinkedList *linkedList = [[KSLinkedList alloc] init];
    KSLinkedNode *node0 = [KSLinkedNode nodeWithObject:mutableDataArray[0]];
    KSLinkedNode *node1 = [KSLinkedNode nodeWithObject:mutableDataArray[1]];
    KSLinkedNode *node2 = [KSLinkedNode nodeWithObject:mutableDataArray[2]];
    KSLinkedNode *node3 = [KSLinkedNode nodeWithObject:mutableDataArray[3]];
    [linkedList addNode:node0];
    [linkedList addNode:node1];
    [linkedList addNode:node2];
    [linkedList addNode:node3];
    
    // Run tests: remove a middle node
    [linkedList removeNode:node2];
    [mutableDataArray removeObject:node2.object];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: remove the head node
    [linkedList removeNode:node0];
    [mutableDataArray removeObject:node0.object];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: remove the tail node
    [linkedList removeNode:node3];
    [mutableDataArray removeObject:node3.object];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
    
    // Run tests: remove the single node
    [linkedList removeNode:node1];
    [mutableDataArray removeObject:node1.object];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}

- (void)test_removeNodesFromNode$toNode$_fromHeadToTail
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [@[ @(0), @(1), @(2), @(3) ] mutableCopy];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:mutableDataArray];
    
    // Run tests
    KSLinkedNode *fromNode = linkedList.headNode;
    KSLinkedNode *toNode = linkedList.tailNode;
    [linkedList removeNodesFromNode:fromNode toNode:toNode];
    NSUInteger fromIndex = [mutableDataArray indexOfObject:fromNode.object];
    NSUInteger toIndex = [mutableDataArray indexOfObject:toNode.object];
    [mutableDataArray removeObjectsInRange:NSMakeRange(fromIndex, toIndex - fromIndex + 1)];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}

- (void)test_removeNodesFromNode$toNode$_fromHeadToNode
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [@[ @(0), @(1), @(2), @(3) ] mutableCopy];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:mutableDataArray];
    
    // Run tests
    KSLinkedNode *fromNode = linkedList.headNode;
    KSLinkedNode *toNode = linkedList.tailNode.prevNode;
    [linkedList removeNodesFromNode:fromNode toNode:toNode];
    NSUInteger fromIndex = [mutableDataArray indexOfObject:fromNode.object];
    NSUInteger toIndex = [mutableDataArray indexOfObject:toNode.object];
    [mutableDataArray removeObjectsInRange:NSMakeRange(fromIndex, toIndex - fromIndex + 1)];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}

- (void)test_removeNodesFromNode$toNode$_fromNodeToTail
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [@[ @(0), @(1), @(2), @(3) ] mutableCopy];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:mutableDataArray];
    
    // Run tests
    KSLinkedNode *fromNode = linkedList.headNode.nextNode;
    KSLinkedNode *toNode = linkedList.tailNode;
    [linkedList removeNodesFromNode:fromNode toNode:toNode];
    NSUInteger fromIndex = [mutableDataArray indexOfObject:fromNode.object];
    NSUInteger toIndex = [mutableDataArray indexOfObject:toNode.object];
    [mutableDataArray removeObjectsInRange:NSMakeRange(fromIndex, toIndex - fromIndex + 1)];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}

- (void)test_removeNodesFromNode$toNode$_fromNode1ToNode2
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [@[ @(0), @(1), @(2), @(3) ] mutableCopy];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:mutableDataArray];
    
    // Run tests
    KSLinkedNode *fromNode = linkedList.headNode.nextNode;
    KSLinkedNode *toNode = linkedList.tailNode.prevNode;
    [linkedList removeNodesFromNode:fromNode toNode:toNode];
    NSUInteger fromIndex = [mutableDataArray indexOfObject:fromNode.object];
    NSUInteger toIndex = [mutableDataArray indexOfObject:toNode.object];
    [mutableDataArray removeObjectsInRange:NSMakeRange(fromIndex, toIndex - fromIndex + 1)];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}

- (void)test_removeNodesFromNode$toNode$_fromNodeToNode
{
    // Initialize test data
    NSMutableArray<NSNumber *> *mutableDataArray = [@[ @(0), @(1), @(2), @(3) ] mutableCopy];
    KSLinkedList *linkedList = [[KSLinkedList alloc] initWithArray:mutableDataArray];
    
    // Run tests
    KSLinkedNode *fromNode = linkedList.headNode.nextNode;
    KSLinkedNode *toNode = fromNode;
    [linkedList removeNodesFromNode:fromNode toNode:toNode];
    NSUInteger fromIndex = [mutableDataArray indexOfObject:fromNode.object];
    NSUInteger toIndex = [mutableDataArray indexOfObject:toNode.object];
    [mutableDataArray removeObjectsInRange:NSMakeRange(fromIndex, toIndex - fromIndex + 1)];
    
    // Assert results
    [self validateNodesInLinkedList:linkedList];
    [self validateValuesInLinkedList:linkedList withArray:mutableDataArray];
}

#pragma mark - Common

- (void)validateNodesInLinkedList:(KSLinkedList *)linkedList
{
    XCTAssertNil(linkedList.headNode.prevNode);
    XCTAssertNil(linkedList.tailNode.nextNode);
    {
        NSMutableArray<KSLinkedNode *> *nodeArray = [[NSMutableArray alloc] init];
        [linkedList enumerateNodesWithOptions:kNilOptions usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
            [nodeArray addObject:node];
        }];
        XCTAssert(linkedList.count == nodeArray.count);
        XCTAssert(linkedList.headNode == nodeArray.firstObject);
        XCTAssert(linkedList.tailNode == nodeArray.lastObject);
    }
    {
        NSMutableArray<KSLinkedNode *> *nodeArray = [[NSMutableArray alloc] init];
        [linkedList enumerateNodesWithOptions:NSEnumerationReverse usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
            [nodeArray insertObject:node atIndex:0];
        }];
        XCTAssert(linkedList.count == nodeArray.count);
        XCTAssert(linkedList.headNode == nodeArray.firstObject);
        XCTAssert(linkedList.tailNode == nodeArray.lastObject);
    }
}

- (void)validateValuesInLinkedList:(KSLinkedList *)linkedList withArray:(NSArray<id> *)array
{
    XCTAssert(linkedList.count == array.count);
    XCTAssert(linkedList.headNode.object == array.firstObject);
    XCTAssert(linkedList.tailNode.object == array.lastObject);
    {
        NSMutableArray<NSNumber *> *resultArray = [[NSMutableArray alloc] init];
        [linkedList enumerateNodesWithOptions:kNilOptions usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
            [resultArray addObject:node.object];
        }];
        XCTAssert(array.count == resultArray.count);
        for (NSUInteger i = 0; i < resultArray.count; i++) {
            XCTAssert(array[i] == resultArray[i]);
        }
    }
    {
        NSMutableArray<NSNumber *> *resultArray = [[NSMutableArray alloc] init];
        [linkedList enumerateNodesWithOptions:NSEnumerationReverse usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
            [resultArray insertObject:node.object atIndex:0];
        }];
        XCTAssert(array.count == resultArray.count);
        for (NSUInteger i = 0; i < resultArray.count; i++) {
            XCTAssert(array[i] == resultArray[i]);
        }
    }
}

@end
