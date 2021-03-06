#import <Cocoa/Cocoa.h>

@interface HMCPhotosWindowController : NSWindowController

@property (strong, nonatomic) NSURL *directory;
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) NSMutableDictionary *photoWindows;

@property (strong) IBOutlet NSPanel *progressPanel;
@property (weak) IBOutlet NSTextField *progressLabel;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;

@property (strong) IBOutlet NSArrayController *photosArrayController;

+ (BOOL)isPhotoType:(NSString *)typeIdentifier;

- (id)initWithDirectory:(NSURL *)directory;

@end
