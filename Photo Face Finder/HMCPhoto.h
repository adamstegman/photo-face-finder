#import <Foundation/Foundation.h>

@interface HMCPhoto : NSObject <NSCopying> {
  NSImage *_image;
  NSString *_name;
  NSArray *_tags;
}

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic, readonly) NSImage *image;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSArray *tags;

- (id)initWithURL:(NSURL *)url;

- (void)insertTags:(NSArray *)tags atIndex:(NSUInteger)index;
- (void)removeTag:(NSString *)tag;

@end
