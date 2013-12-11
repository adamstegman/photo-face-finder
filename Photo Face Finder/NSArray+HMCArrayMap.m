#import "NSArray+HMCArrayMap.h"

@implementation NSArray (HMCArrayMap)

- (NSArray *)arrayByMappingObjectsUsingBlock:(id (^)(id obj))block {
  __block NSMutableArray *newArray = [NSMutableArray array];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [newArray addObject:block(obj)];
  }];
  return newArray;
}

@end
