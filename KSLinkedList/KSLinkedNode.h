//
//  KSLinkedNode.h
//  KSLinkedList
//
//  Created by klaudz on 2020/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSLinkedNode : NSObject

@property (nonatomic, strong, nullable) id object;
@property (nonatomic, strong, nullable) KSLinkedNode *prevNode;
@property (nonatomic, strong, nullable) KSLinkedNode *nextNode;

- (instancetype)initWithObject:(nullable id)object;
+ (instancetype)nodeWithObject:(nullable id)object;

@end

NS_ASSUME_NONNULL_END
