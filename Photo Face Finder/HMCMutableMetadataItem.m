#import "HMCMutableMetadataItem.h"
#import <sys/xattr.h>

@implementation HMCMutableMetadataItem

- (id)initWithURL:(NSURL *)url {
  self = [super initWithURL:url];
  if (self) {
    _url = url;
  }
  return self;
}

- (void)setValue:(NSString *)value forAttribute:(NSString *)attribute {
  setxattr([_url fileSystemRepresentation],
           [attribute UTF8String],
           [value UTF8String],
           [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
           0,
           0);
}

//- (void)setFinderComment:(NSString *)comment {
//  const char *HMCFinderCommentKey = [[NSString stringWithFormat:@"com.apple.metadata:%@", NSMetadataItemFinderCommentKey] UTF8String];
//  
//  NSData *commentBytes = [NSPropertyListSerialization dataWithPropertyList:comment
//                                                                    format:NSPropertyListBinaryFormat_v1_0
//                                                                   options:0
//                                                                     error:NULL];
//  setxattr([_url fileSystemRepresentation],
//           HMCFinderCommentKey,
//           [commentBytes bytes],
//           [commentBytes length],
//           0,
//           0);
//}

@end
