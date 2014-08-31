#import "CVPMetalTextureCache.h"

#import "CVPPixelBuffer+Metal.h"

#if COREVIDEO_SUPPORTS_METAL

@interface CVPMetalTextureCache : NSObject <CVPMetalTextureCache>
{
	CVMetalTextureCacheRef textureCache;
}

@end

@implementation CVPMetalTextureCache

- (instancetype)initWithDevice:(id<MTLDevice>)device cacheAttributes:(NSDictionary *)cacheAttributes textureAttributes:(NSDictionary *)textureAttributes error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		CVReturn status = CVMetalTextureCacheCreate(NULL, (__bridge CFDictionaryRef)cacheAttributes, device, (__bridge CFDictionaryRef)textureAttributes, &textureCache);
		if(status != kCVReturnSuccess)
		{
			NSLog(@"%s:%d:TODO error handling: %d", __FUNCTION__, __LINE__, status);
			return nil;
		}
	}
	return self;
}

- (void)dealloc
{
	if(textureCache != NULL)
	{
		CFRelease(textureCache), textureCache = NULL;
	}
}

- (id<MTLTexture>)textureWithImageBuffer:(CVImageBufferRef)imageBuffer error:(NSError **)error
{
	return [self textureWithImageBuffer:imageBuffer planeIndex:0 flipped:NULL cleanTextureCoordinates:NULL error:error];
}

- (id<MTLTexture>)textureWithImageBuffer:(CVImageBufferRef)imageBuffer planeIndex:(size_t)planeIndex error:(NSError **)error
{
	return [self textureWithImageBuffer:imageBuffer planeIndex:planeIndex flipped:NULL cleanTextureCoordinates:NULL error:error];
}

- (id<MTLTexture>)textureWithImageBuffer:(CVImageBufferRef)imageBuffer planeIndex:(size_t)planeIndex flipped:(BOOL *)flipped cleanTextureCoordinates:(float[8])cleanTextureCoordinates error:(NSError **)error
{
	CVPixelBufferRef pixelBuffer = imageBuffer;
	
	size_t planeCount = CVPixelBufferGetPlaneCount(pixelBuffer);
	if(planeIndex >= planeCount)
	{
		NSLog(@"%s:%d:TODO invalid plane: %ld/%ld", __FUNCTION__, __LINE__, planeIndex, planeCount);
		return nil;
	}

	size_t width = 0;
	size_t height = 0;
	MTLPixelFormat pixelFormat = MTLPixelFormatInvalid;

	if(planeCount > 1) // only use the …OfPlane methods when there are planes
	{
		width = CVPixelBufferGetWidthOfPlane(pixelBuffer, planeIndex);
		height = CVPixelBufferGetHeightOfPlane(pixelBuffer, planeIndex);
		pixelFormat = CVPPixelBufferGetMetalPixelFormatOfPlane(pixelBuffer, planeIndex);
	}
	else
	{
		width = CVPixelBufferGetWidth(pixelBuffer);
		height = CVPixelBufferGetHeight(pixelBuffer);
		pixelFormat = CVPPixelBufferGetMetalPixelFormat(pixelBuffer);
	}
	
	CVMetalTextureRef texture = NULL;
	CVReturn status = CVMetalTextureCacheCreateTextureFromImage(NULL, textureCache, imageBuffer, NULL, pixelFormat, width, height, planeIndex, &texture);
	if(status != kCVReturnSuccess)
	{
		NSLog(@"%s:%d:TODO error handling: %d", __FUNCTION__, __LINE__, status);
		return nil;
	}
	
	if(flipped != NULL)
	{
		*flipped = CVMetalTextureIsFlipped(texture) ? YES : NO;
	}
	
	if(cleanTextureCoordinates != NULL)
	{
		CVMetalTextureGetCleanTexCoords(texture, &cleanTextureCoordinates[0], &cleanTextureCoordinates[2], &cleanTextureCoordinates[4], &cleanTextureCoordinates[6]);
	}
	
	id<MTLTexture> metalTexture = CVMetalTextureGetTexture(texture);
	
	CFRelease(texture);
	
	return metalTexture;
}

- (void)flush
{
	CVMetalTextureCacheFlush(textureCache, 0);
}

@end



@implementation NSObject (CVPMTLTextureCache)

- (id<CVPMetalTextureCache>)newTextureCacheWithAttributes:(NSDictionary *)cacheAttributes textureAttributes:(NSDictionary *)textureAttributes error:(NSError **)error
{
	NSParameterAssert([self conformsToProtocol:@protocol(MTLDevice)]);
	
	id<MTLDevice> device = (id<MTLDevice>)self;
	
	return [[CVPMetalTextureCache alloc] initWithDevice:device cacheAttributes:cacheAttributes textureAttributes:textureAttributes error:error];
}

@end

#endif /* COREVIDEO_SUPPORTS_METAL */
