#import "HMCPhotosWindowController.h"
#import "HMCPhotoWindowController.h"
#import "HMCPhoto.h"

static NSArray *HMCPhotoTypes;

@interface HMCPhotosWindowController ()
+ (NSArray *)photoTypes;
- (NSString *)directoryName;
- (void)indicateNumberOfPhotos;
- (void)indicatePhotoSlurping:(BOOL)inProgress;
- (void)openWindowForPhoto:(HMCPhoto *)photo;
- (void)slurpPhotos;
@end

@implementation HMCPhotosWindowController

+ (BOOL)isPhotoType:(NSString *)typeIdentifier {
  return [[self photoTypes] containsObject:typeIdentifier];
}

- (id)init {
  return [self initWithDirectory:nil];
}

- (id)initWithDirectory:(NSURL *)directory
{
    self = [super initWithWindowNibName:@"HMCPhotosWindowController"];
    if (self) {
      _directory = directory;
      _photos = [NSMutableArray array];
    }
    return self;
}

- (void)windowDidLoad
{
  [super windowDidLoad];

  // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

  self.window.title = [self directoryName];

  [self.photosArrayController addObserver:self
                               forKeyPath:@"selectionIndex"
                                  options:NSKeyValueObservingOptionNew
                                  context:nil];

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
    [self slurpPhotos];
  });
}

+ (NSArray *)photoTypes {
  if (!HMCPhotoTypes) {
    HMCPhotoTypes = @[@"public.jpeg"];
  }
  return HMCPhotoTypes;
}

- (NSString *)directoryName {
  return [[self.directory pathComponents] lastObject];
}

- (void)indicateNumberOfPhotos {
  self.progressLabel.stringValue = [NSString stringWithFormat:@"Found %lu photos in %@...",
                                    (unsigned long)[self countOfPhotos],
                                    [self directoryName]];
}

- (void)indicatePhotoSlurping:(BOOL)inProgress
{
  if (inProgress) {
    [self.progressIndicator startAnimation:nil];
    [self indicateNumberOfPhotos];
    [self.window beginSheet:self.progressPanel completionHandler:nil];
  } else {
    [self.window endSheet:self.progressPanel];
    [self.progressIndicator stopAnimation:nil];
  }
}

- (void)openWindowForPhoto:(HMCPhoto *)photo {
  if (!self.photoWindows) {
    self.photoWindows = [NSMutableDictionary dictionary];
  }
  if (!self.photoWindows[photo.url]) {
    HMCPhotoWindowController *photoWindow = [[HMCPhotoWindowController alloc] initWithPhoto:photo];
    self.photoWindows[photo.url] = photoWindow;
  }
  [self.photoWindows[photo.url] showWindow:nil];
}

- (void)slurpPhotos {
  [self indicatePhotoSlurping:YES];
  NSDirectoryEnumerator *photoEnumerator = [[NSFileManager defaultManager]
                                            enumeratorAtURL:self.directory
                                            includingPropertiesForKeys:@[NSURLCreationDateKey, NSURLIsReadableKey, NSURLNameKey, NSURLPathKey, NSURLTypeIdentifierKey]
                                            options:NSDirectoryEnumerationSkipsHiddenFiles
                                            errorHandler:nil];
  for (NSURL *photoResource in photoEnumerator) {
    NSNumber *isReadable;
    [photoResource getResourceValue:&isReadable forKey:NSURLIsReadableKey error:NULL];
    if ([isReadable boolValue]) {
      NSString *photoType;
      [photoResource getResourceValue:&photoType forKey:NSURLTypeIdentifierKey error:NULL];
      if ([self.class isPhotoType:photoType]) {
        HMCPhoto *photo = [[HMCPhoto alloc] initWithURL:photoResource];
        [self insertObject:photo inPhotosAtIndex:[self countOfPhotos]];
        [self indicateNumberOfPhotos];
      }
    }
  }
  [self indicatePhotoSlurping:NO];
}

#pragma mark - observing selected photos

-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if ([keyPath isEqualTo:@"selectionIndex"] && [self.photosArrayController selectionIndex]) {
    HMCPhoto *selectedPhoto = [[self.photosArrayController selectedObjects] firstObject];
    [self openWindowForPhoto:selectedPhoto];
  }
}

#pragma mark - photos KVO-compliance

- (NSUInteger)countOfPhotos {
  return [self.photos count];
}

- (void)insertObject:(HMCPhoto *)object inPhotosAtIndex:(NSUInteger)index {
  [self.photos insertObject:object atIndex:index];
}

- (void)insertPhotos:(NSArray *)array atIndexes:(NSIndexSet *)indexes {
  [self.photos insertObjects:array atIndexes:indexes];
}

- (id)objectInPhotosAtIndex:(NSUInteger)index {
  return [self.photos objectAtIndex:index];
}

- (NSArray *)photosAtIndexes:(NSIndexSet *)indexes {
  return [self.photos objectsAtIndexes:indexes];
}

- (void)removeObjectFromPhotosAtIndex:(NSUInteger)index {
  [self.photos removeObjectAtIndex:index];
}

- (void)removePhotosAtIndexes:(NSIndexSet *)indexes {
  [self.photos removeObjectsAtIndexes:indexes];
}

@end
