#import <CoreVideo/CoreVideo.h>

#if COREVIDEO_SUPPORTS_METAL

#import <CoreVideo/CVMetalTextureCache.h>
#import <Metal/Metal.h>

@protocol CVPMetalTextureCache <NSObject>
@required

- (id<MTLTexture>)textureWithImageBuffer:(CVImageBufferRef)imageBuffer error:(NSError **)error;
- (id<MTLTexture>)textureWithImageBuffer:(CVImageBufferRef)imageBuffer planeIndex:(size_t)planeIndex error:(NSError **)error;
- (id<MTLTexture>)textureWithImageBuffer:(CVImageBufferRef)imageBuffer planeIndex:(size_t)planeIndex flipped:(BOOL *)flipped cleanTextureCoordinates:(float[8])cleanTextureCoordinates error:(NSError **)error;

- (void)flush;

@end


@protocol CVPMetalDevice <MTLDevice>

- (id<CVPMetalTextureCache>)newTextureCacheWithAttributes:(NSDictionary *)cacheAttributes textureAttributes:(NSDictionary *)textureAttributes error:(NSError **)error;

@end

#endif /* COREVIDEO_SUPPORTS_METAL */
