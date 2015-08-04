#import <CoreVideo/CoreVideo.h>
#import <Foundation/Foundation.h>


@class CVPPixelBuffer;


@interface CVPPixelBufferPool : NSObject

- (instancetype)initWithPoolAttributes:(NSDictionary *)poolAttributes bufferAttributes:(NSDictionary *)bufferAttributes error:(NSError **)error;

- (CVPixelBufferRef)createBufferWithError:(NSError **)error;

- (CVPPixelBuffer *)bufferWithError:(NSError **)error;

@end
