#import <Foundation/Foundation.h>

@interface HMCPhoto : NSObject <NSCopying> {
  NSImage *_image;
  NSString *_name;
}

@property (strong, nonatomic) NSURL *url;

- (id)initWithURL:(NSURL *)url;

- (NSImage *)image;
- (NSString *)name;

@end
