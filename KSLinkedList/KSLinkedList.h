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

@end

NS_ASSUME_NONNULL_END
