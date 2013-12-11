#import <Foundation/Foundation.h>

@class HMCPhotoTag;

@protocol HMCPhotoTagDelegate <NSObject>
@optional
- (void)tagWillBeDeleted:(HMCPhotoTag *)tag;
@end
