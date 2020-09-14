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
