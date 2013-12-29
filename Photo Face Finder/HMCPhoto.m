#import "HMCPhoto.h"
#import "HMCMutableMetadataItem.h"
#import <sys/xattr.h>

@interface HMCPhoto ()
- (HMCMutableMetadataItem *)metadataItem;
@end

@implementation HMCPhoto

@dynamic image;
@dynamic name;
@dynamic tags;
@dynamic comment;

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

- (NSString *)comment {
  return [[self metadataItem] valueForAttribute:NSMetadataItemFinderCommentKey];
}

- (void)setComment:(NSString *)comment {
  // FIXME: use a custom attribute
//  [[self metadataItem] setFinderComment:comment];
  
//  setxattr([self.url fileSystemRepresentation],
//           [NSMetadataItemFinderCommentKey UTF8String],
//           [comment UTF8String],
//           [comment lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
//           0,
//           0);
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
  NSArray *tagNames;
  [self.url getResourceValue:&tagNames forKey:NSURLTagNamesKey error:NULL];
  if (tagNames) {
    return tagNames;
  } else {
    return [NSArray array];
  }
}

- (void)insertTags:(NSArray *)tags atIndex:(NSUInteger)index {
  NSArray *newTags = [self.tags arrayByAddingObjectsFromArray:tags];
  [self.url setResourceValue:newTags forKey:NSURLTagNamesKey error:NULL];
}

- (void)removeTag:(NSString *)tag {
  NSMutableArray *newTags = [self.tags mutableCopy];
  [newTags removeObject:tag];
  [self.url setResourceValue:newTags forKey:NSURLTagNamesKey error:NULL];
}

- (HMCMutableMetadataItem *)metadataItem {
  if (!_metadataItem && self.url) {
    _metadataItem = [[HMCMutableMetadataItem alloc] initWithURL:self.url];
  }
  return _metadataItem;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  return [[[self class] allocWithZone:zone] initWithURL:self.url];
}

@end
