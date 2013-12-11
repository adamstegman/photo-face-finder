#import "HMCAppDelegate.h"
#import "HMCPhotosWindowController.h"

@interface HMCAppDelegate ()
- (void)openWindowForDirectory:(NSURL *)directory;
- (NSURL *)requestPhotoDirectory;
@end

@implementation HMCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
  NSURL *directory = [self requestPhotoDirectory];
  if (directory) {
    [self openWindowForDirectory:directory];
  }
}

- (void)openWindowForDirectory:(NSURL *)directory {
  if (!self.directoryWindows) {
    self.directoryWindows = [NSMutableDictionary dictionary];
  }
  HMCPhotosWindowController *photosWindow = [[HMCPhotosWindowController alloc] initWithDirectory:directory];
  self.directoryWindows[directory] = photosWindow;
  [photosWindow showWindow:nil];
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
