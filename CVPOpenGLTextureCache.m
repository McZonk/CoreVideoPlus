#import "CVPOpenGLTextureCache.h"

#import <CoreVideo/CoreVideo.h>

#import "NSError+CVPError.h"
#import "GLPPixelformat+CVPPixelformat.h"
#import "CVPOpenGLTexture.h"


@interface CVPOpenGLTextureCache ()
{
@private
	CVOpenGLTextureCacheRef textureCache;
}

@end


@implementation CVPOpenGLTextureCache

+ (instancetype)textureCacheWithContext:(CGLContextObj)context error:(NSError **)error
{
	return [[self alloc] initWithContext:context error:error];
}

- (instancetype)initWithContext:(CGLContextObj)context error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		CVReturn err = CVOpenGLTextureCacheCreate(kCFAllocatorDefault, NULL, context, CGLGetPixelFormat(context), NULL, &textureCache);
		if(err != kCVReturnSuccess)
		{
			if(error != nil)
			{
				*error = [NSError errorWithDomain:CVPErrorDomain code:err userInfo:nil];
			}
			
			return nil;
		}
	}
	return self;
}

- (void)dealloc
{
	if(textureCache)
	{
		CFRelease(textureCache), textureCache = nil;
	}
}

- (CVPOpenGLTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer error:(NSError **)error
{
	CVOpenGLTextureRef texture = NULL;
	CVReturn err = CVOpenGLTextureCacheCreateTextureFromImage(kCFAllocatorDefault, textureCache, pixelBuffer, NULL, &texture);
	if(err != kCVReturnSuccess)
	{
		if(error != nil)
		{
			*error = [NSError errorWithDomain:CVPErrorDomain code:err userInfo:nil];
		}
		
		if(texture != NULL)
		{
			CFRelease(texture), texture = NULL;
		}
		
		return nil;
	}
	
	return [CVPOpenGLTexture textureWithCVOpenGLTexture:texture];
	
}

- (void)flush
{
	CVOpenGLTextureCacheFlush(textureCache, 0);
}

@end
