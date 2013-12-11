#import <Foundation/Foundation.h>

@interface NSArray (HMCArrayMap)
- (NSArray *)arrayByMappingObjectsUsingBlock:(id (^)(id obj))block;
@end
