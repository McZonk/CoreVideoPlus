#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>
#import <OpenGL/OpenGL.h>

#import <OpenGLPlus/GLPPixelformat.h>


@class CVPOpenGLTexture;


@interface CVPOpenGLTextureCache : NSObject

+ (instancetype)textureCacheWithContext:(CGLContextObj)context error:(NSError **)error;

- (instancetype)initWithContext:(CGLContextObj)context error:(NSError **)error;

- (CVPOpenGLTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer error:(NSError **)error;

- (void)flush;

@end
