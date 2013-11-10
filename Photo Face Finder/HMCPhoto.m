#import "HMCPhoto.h"

@interface HMCPhoto ()
@end

@implementation HMCPhoto

@dynamic image;
@dynamic name;
@dynamic tags;

- (id)init {
  return [self initWithURL:nil];
}

- (id)initWithURL:(NSURL *)url {
  self = [super init];
  if (self) {
    _url = url;
  }
  return self;
}

- (NSImage *)image {
  if (!_image && self.url) {
    NSString *photoPath;
    [self.url getResourceValue:&photoPath forKey:NSURLPathKey error:NULL];
    _image = [[NSImage alloc] initWithContentsOfFile:photoPath];
  }
  return _image;
}

- (NSString *)name {
  if (!_name && self.url) {
    NSString *photoName;
    [self.url getResourceValue:&photoName forKey:NSURLNameKey error:NULL];
    _name = photoName;
  }
  return _name;
}

- (NSArray *)tags {
  NSArray *tags;
  [self.url getResourceValue:&tags forKey:NSURLTagNamesKey error:NULL];
  if (tags) {
    return tags;
  } else {
    return [NSArray array];
  }
}

- (void)insertTags:(NSArray *)tags atIndex:(NSUInteger)index {
  NSMutableArray *newTags = [self.tags mutableCopy];
  [newTags insertObjects:tags atIndexes:[NSIndexSet indexSetWithIndex:index]];
  [self.url setResourceValue:newTags forKey:NSURLTagNamesKey error:NULL];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  return [[[self class] allocWithZone:zone] initWithURL:self.url];
}

@end
