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

- (instancetype)initWithArray:(NSArray *)array;
+ (instancetype)listWithArray:(NSArray *)array;

- (void)enumerateNodesUsingBlock:(void (^)(KSLinkedNode *node, NSUInteger index, BOOL *stop))block;
- (void)enumerateNodesWithOptions:(NSEnumerationOptions)options usingBlock:(void (^)(KSLinkedNode *node, NSUInteger index, BOOL *stop))block;

- (void)addNode:(KSLinkedNode *)node;
- (void)unshiftNode:(KSLinkedNode *)node;
- (void)insertNode:(KSLinkedNode *)node atIndex:(NSUInteger)index;
- (void)insertNode:(KSLinkedNode *)node afterNode:(KSLinkedNode *)siblingNode;

- (void)removeNode:(KSLinkedNode *)node;

@end

NS_ASSUME_NONNULL_END
