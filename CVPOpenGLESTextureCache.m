#import "CVPOpenGLESTextureCache.h"

#import <CoreVideo/CoreVideo.h>

#import "NSError+CVPError.h"
#import "GLPPixelformat+CVPPixelformat.h"
#import "CVPOpenGLESTexture.h"


@interface CVPOpenGLESTextureCache ()
{
@private
	CVOpenGLESTextureCacheRef textureCache;
}

@end


@implementation CVPOpenGLESTextureCache

+ (instancetype)textureCacheWithContext:(EAGLContext *)context error:(NSError **)error
{
	return [[self alloc] initWithContext:context error:error];
}

- (instancetype)initWithContext:(EAGLContext *)context error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		CVReturn err = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, context, NULL, &textureCache);
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

- (CVPOpenGLESTexture*)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer error:(NSError**)error
{
	return [self textureWithPixelBuffer:pixelBuffer plane:0 error:error];
}

- (CVPOpenGLESTexture*)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer plane:(size_t)plane error:(NSError**)error
{
	GLPPixelformat pixelformat = glpPixelformatFromCVPixelBuffer(pixelBuffer, plane);
	
	size_t width = 0;
	size_t height = 0;
	
	size_t planeCount = CVPixelBufferGetPlaneCount(pixelBuffer);
	if(planeCount != 0)
	{
		// this will return 0 if the pixel buffer is single planar
		width = CVPixelBufferGetWidthOfPlane(pixelBuffer, plane);
		height = CVPixelBufferGetHeightOfPlane(pixelBuffer, plane);
	}
	else
	{
		width = CVPixelBufferGetWidth(pixelBuffer);
		height = CVPixelBufferGetHeight(pixelBuffer);
	}
	
	return [self textureWithPixelBuffer:pixelBuffer pixelformat:pixelformat width:(GLuint)width height:(GLuint)height plane:plane error:error];
}

- (CVPOpenGLESTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer pixelformat:(GLPPixelformat)pixelformat width:(GLsizei)width height:(GLsizei)height error:(NSError **)error
{
	return [self textureWithPixelBuffer:pixelBuffer pixelformat:pixelformat width:width height:height plane:0 error:error];
}

- (CVPOpenGLESTexture *)textureWithPixelBuffer:(CVPixelBufferRef)pixelBuffer pixelformat:(GLPPixelformat)pixelformat width:(GLsizei)width height:(GLsizei)height plane:(size_t)plane error:(NSError **)error
{
	const GLenum internalFormat = glpPixelformatGetInternalFormat(pixelformat);
	const GLenum format = glpPixelformatGetFormat(pixelformat);
	const GLenum type = glpPixelformatGetType(pixelformat);

	CVOpenGLESTextureRef texture = NULL;
	CVReturn err = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault, textureCache, pixelBuffer, NULL, GL_TEXTURE_2D, internalFormat, width, height, format, type, plane, &texture);
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
	
	return [CVPOpenGLESTexture textureWithCVOpenGLESTexture:texture];
	
}

- (void)flush
{
	CVOpenGLESTextureCacheFlush(textureCache, 0);
}

@end
