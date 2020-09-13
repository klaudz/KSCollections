//
//  KSLinkedList.h
//  KSLinkedList
//
//  Created by klaudz on 2020/9/14.
//

#import <Foundation/Foundation.h>
#import "KSLinkedNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSLinkedList : NSObject

@property (nonatomic, strong, nullable) KSLinkedNode *headNode;
@property (nonatomic, strong, nullable) KSLinkedNode *tailNode;

@property (nonatomic, assign) NSUInteger count;

- (void)enumerateNodesUsingBlock:(void (^)(KSLinkedNode *node, NSUInteger index, BOOL *stop))block;
- (void)enumerateNodesWithOptions:(NSEnumerationOptions)options usingBlock:(void (^)(KSLinkedNode *node, NSUInteger index, BOOL *stop))block;

- (void)addNode:(KSLinkedNode *)node;

@end

NS_ASSUME_NONNULL_END
