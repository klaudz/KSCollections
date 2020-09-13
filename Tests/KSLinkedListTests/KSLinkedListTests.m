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
    XCTAssert(linkedList.count == testDataArray.count);
    XCTAssert(linkedList.headNode.object == testDataArray.firstObject);
    XCTAssert(linkedList.tailNode.object == testDataArray.lastObject);
    {
        NSMutableArray<NSNumber *> *resultDataArray = [[NSMutableArray alloc] init];
        [linkedList enumerateNodesWithOptions:kNilOptions usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
            [resultDataArray addObject:node.object];
        }];
        for (NSUInteger i = 0; i < resultDataArray.count; i++) {
            XCTAssert([testDataArray[i] isEqualToNumber:resultDataArray[i]]);
        }
    }
    {
        NSMutableArray<NSNumber *> *resultDataArray = [[NSMutableArray alloc] init];
        [linkedList enumerateNodesWithOptions:NSEnumerationReverse usingBlock:^(KSLinkedNode * _Nonnull node, NSUInteger index, BOOL * _Nonnull stop) {
            [resultDataArray insertObject:node.object atIndex:0];
        }];
        for (NSUInteger i = 0; i < resultDataArray.count; i++) {
            XCTAssert([testDataArray[i] isEqualToNumber:resultDataArray[i]]);
        }
    }
}

@end
