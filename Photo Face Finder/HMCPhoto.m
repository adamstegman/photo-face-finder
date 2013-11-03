#import "HMCPhoto.h"

@implementation HMCPhoto

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

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  // FIXME: copy attributes if adding something mutable like tags
  return self;
}

@end
