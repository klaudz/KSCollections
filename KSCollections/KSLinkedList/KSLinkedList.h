//
//  KSLinkedList.h
//  KSCollections
//
//  Created by klaudz on 2020/9/14.
//

#import <Foundation/Foundation.h>
#import "KSLinkedNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSLinkedList : NSObject

@property (nonatomic, strong, nullable) __kindof KSLinkedNode *headNode;
@property (nonatomic, strong, nullable) __kindof KSLinkedNode *tailNode;

@property (nonatomic, assign) NSUInteger count;

- (instancetype)initWithArray:(NSArray *)array;
+ (instancetype)listWithArray:(NSArray *)array;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)listWithDictionary:(NSDictionary *)dictionary;

- (void)enumerateNodesUsingBlock:(void (^)(__kindof KSLinkedNode *node, NSUInteger index, BOOL *stop))block;
- (void)enumerateNodesWithOptions:(NSEnumerationOptions)options usingBlock:(void (^)(__kindof KSLinkedNode *node, NSUInteger index, BOOL *stop))block;

- (__kindof KSLinkedNode *)nodeAtIndex:(NSUInteger)index;

- (void)addNode:(KSLinkedNode *)node;
- (void)insertHeadNode:(KSLinkedNode *)node;
- (void)insertNode:(KSLinkedNode *)node atIndex:(NSUInteger)index;
- (void)insertNode:(KSLinkedNode *)node afterNode:(KSLinkedNode *)siblingNode;
- (void)insertNode:(KSLinkedNode *)node beforeNode:(KSLinkedNode *)siblingNode;

- (void)removeNode:(KSLinkedNode *)node;
- (void)removeNodeAtIndex:(NSUInteger)index;
- (void)removeHeadNode;
- (void)removeTailNode;

- (void)removeAllNodes;
- (void)removeNodesFromNode:(KSLinkedNode *)fromNode toNode:(KSLinkedNode *)toNode;
- (void)removeNodesFromNode:(KSLinkedNode *)fromNode;
- (void)removeNodesAfterNode:(KSLinkedNode *)afterNode;
- (void)removeNodesToNode:(KSLinkedNode *)toNode;
- (void)removeNodesBeforeNode:(KSLinkedNode *)beforeNode;

@end

NS_ASSUME_NONNULL_END
