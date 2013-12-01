#import "HMCPhotoWindowController.h"
#import "HMCPhoto.h"

@interface HMCPhotoWindowController ()
@end

@implementation HMCPhotoWindowController

- (id)init {
  return [self initWithPhoto:nil];
}

- (id)initWithPhoto:(HMCPhoto *)photo {
  self = [super initWithWindowNibName:@"HMCPhotoWindowController"];
  if (self) {
    _photo = photo;
  }
  return self;
}

- (void)windowDidLoad
{
  [super windowDidLoad];
    
  // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

  self.window.title = self.photo.name;
  self.window.representedURL = self.photo.url;
  self.photoView.image = self.photo.image;
  self.tagsField.objectValue = self.photo.tags;
  self.tagsField.delegate = self;
}

#pragma mark - NSTokenFieldDelegate

- (NSArray *)tokenField:(NSTokenField *)tokenField shouldAddObjects:(NSArray *)tokens atIndex:(NSUInteger)index {
  NSArray *existingTags = self.photo.tags;
  NSMutableArray *addedTags = [NSMutableArray array];
  for (NSString *tag in tokens) {
    if (![existingTags containsObject:tag]) {
      [addedTags addObject:tag];
    }
  }
  [self.photo insertTags:addedTags atIndex:index];
  return addedTags;
}

@end
