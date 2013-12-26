#import <Foundation/Foundation.h>

@interface NSArray (HMCArrayMap)
- (NSArray *)arrayByMappingObjectsUsingBlockWithHMC:(id (^)(id obj))block;
@end
