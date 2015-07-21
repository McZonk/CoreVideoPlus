#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>
#import <OpenGL/OpenGL.h>

#import <OpenGLPlus/GLPPixelformat.h>


@class CVPOpenGLTexture;


@interface CVPOpenGLTextureCache : NSObject

+ (instancetype)textureCacheWithContext:(CGLContextObj)context error:(NSError **)error;

- (instancetype)initWithContext:(CGLContextObj)context error:(NSError **)error;

- (CVPOpenGLTexture *)textureWithImageBuffer:(CVImageBufferRef)imageBuffer error:(NSError **)error;

- (void)flush;

@end
