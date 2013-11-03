#import <Cocoa/Cocoa.h>

@class HMCPhoto;

@interface HMCPhotoWindowController : NSWindowController

@property (weak) IBOutlet NSImageView *photoView;
@property (weak) IBOutlet NSTokenField *tagsField;

@property (strong, nonatomic) HMCPhoto *photo;

- (id)initWithPhoto:(HMCPhoto *)photo;

@end
