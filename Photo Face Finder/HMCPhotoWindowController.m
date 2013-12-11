#import "HMCPhotoWindowController.h"
#import "HMCPhoto.h"
#import "HMCPhotoTag.h"
#import "NSArray+HMCArrayMap.h"

@interface HMCPhotoWindowController ()
- (NSArray *)photoTagsFromTagNames:(NSArray *)tagNames;
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
  self.tagsField.delegate = self;
  self.tagsField.objectValue = [self photoTagsFromTagNames:self.photo.tags];
}

- (NSArray *)photoTagsFromTagNames:(NSArray *)tagNames {
  __weak __block id _self = self;
  return [tagNames arrayByMappingObjectsUsingBlock:^id (id obj) {
    return [_self tokenField:nil representedObjectForEditingString:obj];
  }];
}

#pragma mark - NSTokenFieldDelegate

- (NSArray *)tokenField:(NSTokenField *)tokenField shouldAddObjects:(NSArray *)tokens atIndex:(NSUInteger)index {
  NSArray *existingTags = self.photo.tags;
  NSMutableArray *addedTagNames = [NSMutableArray array];
  NSMutableArray *addedTags = [NSMutableArray array];
  for (HMCPhotoTag *tag in tokens) {
    if (![existingTags containsObject:tag.name]) {
      [addedTagNames addObject:tag.name];
      [addedTags addObject:tag];
    }
  }
  [self.photo insertTags:addedTagNames atIndex:index];
  return addedTags;
}

- (NSString *)tokenField:(NSTokenField *)tokenField displayStringForRepresentedObject:(id)representedObject {
  if ([representedObject isKindOfClass:[HMCPhotoTag class]]) {
    return ((HMCPhotoTag *)representedObject).name;
  }
  return nil;
}

- (id)tokenField:(NSTokenField *)tokenField representedObjectForEditingString:(NSString *)editingString {
  HMCPhotoTag *photoTag = [[HMCPhotoTag alloc] initWithName:editingString];
  photoTag.delegate = self;
  return photoTag;
}

#pragma mark - HMCPhotoTagDelegate

- (void)tagWillBeDeleted:(HMCPhotoTag *)tag {
  [self.photo removeTag:tag.name];
}

@end
