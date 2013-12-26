#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLPlus/GLPPixelformat.h>

@class CVPOpenGLESTexture;


@interface CVOpenGLESTextureCache : NSObject

+ (instancetype)textureCacheWithContext:(EAGLContext *)context error:(NSError **)error;

- (instancetype)initWithContext:(EAGLContext *)context error:(NSError **)error;

- (CVPOpenGLESTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer error:(NSError **)error;

- (CVPOpenGLESTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer plane:(size_t)plane error:(NSError **)error;

- (CVPOpenGLESTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer pixelformat:(GLPPixelformat)pixelformat width:(GLsizei)width height:(GLsizei)height error:(NSError **)error;

- (CVPOpenGLESTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer pixelformat:(GLPPixelformat)pixelformat width:(GLsizei)width height:(GLsizei)height plane:(size_t)plane error:(NSError **)error;

- (void)flush;

@end
