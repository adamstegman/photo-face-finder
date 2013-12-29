#import <Cocoa/Cocoa.h>
#import "HMCPhotoTagDelegate.h"

@class HMCPhoto;

@interface HMCPhotoWindowController : NSWindowController <NSTextFieldDelegate, NSTokenFieldDelegate, HMCPhotoTagDelegate>

@property (weak) IBOutlet NSImageView *photoView;
@property (weak) IBOutlet NSTokenField *tagsField;
@property (weak) IBOutlet NSTextField *commentField;

@property (strong, nonatomic) HMCPhoto *photo;

- (id)initWithPhoto:(HMCPhoto *)photo;

@end
