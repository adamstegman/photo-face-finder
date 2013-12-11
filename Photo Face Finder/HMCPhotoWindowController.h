#import <Cocoa/Cocoa.h>
#import "HMCPhotoTagDelegate.h"

@class HMCPhoto;

@interface HMCPhotoWindowController : NSWindowController <NSTokenFieldDelegate, HMCPhotoTagDelegate>

@property (weak) IBOutlet NSImageView *photoView;
@property (weak) IBOutlet NSTokenField *tagsField;

@property (strong, nonatomic) HMCPhoto *photo;

- (id)initWithPhoto:(HMCPhoto *)photo;

@end
