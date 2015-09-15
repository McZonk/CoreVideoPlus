#import <CoreVideo/CoreVideo.h>
#import <Foundation/Foundation.h>



@interface CVPPixelBuffer : NSObject

+ (instancetype)bufferWithCVPixelBuffer:(CVPixelBufferRef)buffer;

- (instancetype)initWithCVPixelBuffer:(CVPixelBufferRef)buffer;

- (CVPixelBufferRef)CVPixelBuffer NS_RETURNS_INNER_POINTER;

@end


#if COREVIDEO_SUPPORTS_IOSURFACE

@interface CVPPixelBuffer (IOSurface)

- (IOSurfaceRef)IOSurface NS_RETURNS_INNER_POINTER;

@end

#endif
