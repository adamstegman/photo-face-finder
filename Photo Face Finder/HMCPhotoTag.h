#import <Foundation/Foundation.h>
#import "HMCPhotoTagDelegate.h"

@interface HMCPhotoTag : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (weak, nonatomic) id <HMCPhotoTagDelegate> delegate;

- (id)initWithName:(NSString *)name;

@end
