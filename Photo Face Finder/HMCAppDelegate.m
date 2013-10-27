#import "HMCAppDelegate.h"

@interface HMCAppDelegate ()
- (NSURL *)requestPhotoDirectory;
@end

@implementation HMCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  NSURL *directory = [self requestPhotoDirectory];
  NSLog(@"Chose directory: %@", [directory description]);
  // TODO: handle nil
}

- (NSURL *)requestPhotoDirectory {
  NSOpenPanel *openPanel = [NSOpenPanel openPanel];
  openPanel.canChooseDirectories = YES;
  openPanel.canChooseFiles = NO;
  openPanel.allowsMultipleSelection = NO;
  if ([openPanel runModal] == NSFileHandlingPanelOKButton) {
    return [openPanel URLs][0];
  } else {
    return nil;
  }
}

@end
