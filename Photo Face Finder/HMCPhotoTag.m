#import "HMCPhotoTag.h"

@implementation HMCPhotoTag

- (id)init {
  return [self initWithName:nil];
}

- (id)initWithName:(NSString *)name {
  self = [super init];
  if (self) {
    _name = name;
  }
  return self;
}

- (void)dealloc {
  [self.delegate tagWillBeDeleted:self];
}

#pragma mark - NSCoder

// NSCoder routines necessary for token drag and drop

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [encoder encodeObject:self.name];
}

- (id)initWithCoder:(NSCoder *)decoder
{
  _name = [decoder decodeObject];
  return self;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
  return ([object isKindOfClass:[self class]]) && ([object name] == self.name);
}

- (NSUInteger)hash {
  return [self.name hash];
}

@end
