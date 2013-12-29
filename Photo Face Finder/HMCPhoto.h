#import <Foundation/Foundation.h>

@class HMCMutableMetadataItem;

@interface HMCPhoto : NSObject <NSCopying> {
  NSImage *_image;
  NSString *_name;
  NSArray *_tags;
  NSString *_comment;
  HMCMutableMetadataItem *_metadataItem;
}

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic, readonly) NSImage *image;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSArray *tags;
@property (strong, nonatomic) NSString *comment;

- (id)initWithURL:(NSURL *)url;

- (void)insertTags:(NSArray *)tags atIndex:(NSUInteger)index;
- (void)removeTag:(NSString *)tag;

@end
