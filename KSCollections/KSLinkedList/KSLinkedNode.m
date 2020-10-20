//
//  KSLinkedNode.m
//  KSCollections
//
//  Created by klaudz on 2020/9/13.
//

#import "KSLinkedNode.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KSLinkedNode

- (instancetype)initWithObject:(nullable id)object
{
    self = [self init];
    if (self) {
        _object = [object retain];
    }
    return self;
}

+ (instancetype)nodeWithObject:(nullable id)object
{
    return [[[self alloc] initWithObject:object] autorelease];
}

- (void)dealloc
{
    [_key release];
    [_object release];
    
    [_prevNode release];
    [_nextNode release];
    
    [super dealloc];
}

@end

NS_ASSUME_NONNULL_END
