#import <Foundation/Foundation.h>

@interface HMCMutableMetadataItem : NSMetadataItem {
  NSURL *_url;
}

- (void)setValue:(NSString *)value forAttribute:(NSString *)attribute;

//- (void)setFinderComment:(NSString *)comment;

@end
