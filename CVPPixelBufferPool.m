#import "CVPPixelBufferPool.h"

#import "CVPPixelBuffer.h"


@interface CVPPixelBufferPool ()
{
@private
	CVPixelBufferPoolRef bufferPool;
}

@end


@implementation CVPPixelBufferPool

#if 0
CV_EXPORT const CFStringRef kCVPixelBufferPoolMinimumBufferCountKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);
CV_EXPORT const CFStringRef kCVPixelBufferPoolMaximumBufferAgeKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);

CV_EXPORT const CFStringRef kCVPixelBufferPixelFormatTypeKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);		    // A single CFNumber or a CFArray of CFNumbers (OSTypes)
CV_EXPORT const CFStringRef kCVPixelBufferMemoryAllocatorKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);		    // CFAllocatorRef
CV_EXPORT const CFStringRef kCVPixelBufferWidthKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);			    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferHeightKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);			    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferExtendedPixelsLeftKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);	    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferExtendedPixelsTopKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);		    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferExtendedPixelsRightKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);	    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferExtendedPixelsBottomKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);	    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferBytesPerRowAlignmentKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);	    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferCGBitmapContextCompatibilityKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);  // CFBoolean
CV_EXPORT const CFStringRef kCVPixelBufferCGImageCompatibilityKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);	    // CFBoolean
CV_EXPORT const CFStringRef kCVPixelBufferOpenGLCompatibilityKey __OSX_AVAILABLE_STARTING(__MAC_10_4,__IPHONE_4_0);	    // CFBoolean
CV_EXPORT const CFStringRef kCVPixelBufferPlaneAlignmentKey __OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_4_0);		    // CFNumber
CV_EXPORT const CFStringRef kCVPixelBufferIOSurfacePropertiesKey __OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_4_0);     // CFDictionary; presence requests buffer allocation via IOSurface
CV_EXPORT const CFStringRef kCVPixelBufferOpenGLESCompatibilityKey __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);	    // CFBoolean
CV_EXPORT const CFStringRef kCVPixelBufferMetalCompatibilityKey __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_8_0);	    // CFBoolean

#endif

- (instancetype)initWithPoolAttributes:(NSDictionary *)poolAttributes bufferAttributes:(NSDictionary *)bufferAttributes error:(NSError **)error
{
	self = [super init];
	if (self != nil)
	{
		CVReturn err = CVPixelBufferPoolCreate(NULL, (__bridge CFDictionaryRef)poolAttributes, (__bridge CFDictionaryRef)bufferAttributes, &bufferPool);
		if(err != kCVReturnSuccess)
		{
			if(error != nil)
			{
				*error = [NSError errorWithDomain:NSOSStatusErrorDomain code:err userInfo:nil];
			}
			else
			{
				NSLog(@"%s:%d:ERROR: %d", __FUNCTION__, __LINE__, err);
			}
		}
	}
	return self;
}

- (void)dealloc
{
	CVPixelBufferPoolRelease(bufferPool);
}

- (NSDictionary *)poolAttributes
{
	return (__bridge NSDictionary *)CVPixelBufferPoolGetAttributes(bufferPool);
}

- (NSDictionary *)bufferAttributes
{
	return (__bridge NSDictionary *)CVPixelBufferPoolGetPixelBufferAttributes(bufferPool);
}

- (CVPixelBufferRef)createBufferWithError:(NSError **)error
{
	CVPixelBufferRef buffer = NULL;
	CVReturn err = CVPixelBufferPoolCreatePixelBuffer(NULL, bufferPool, &buffer);
	if(err != kCVReturnSuccess)
	{
		if(error != nil)
		{
			*error = [NSError errorWithDomain:NSOSStatusErrorDomain code:err userInfo:nil];
		}
		else
		{
			NSLog(@"%s:%d:ERROR: %d", __FUNCTION__, __LINE__, err);
		}
	}
	return buffer;
}

- (CVPPixelBuffer *)bufferWithError:(NSError **)error
{
	CVOpenGLBufferRef buffer = [self createBufferWithError:error];
	if (buffer == NULL)
	{
		return NULL;
	}
	
	CVPPixelBuffer *bufferObject = [[CVPPixelBuffer alloc] initWithCVPixelBuffer:buffer];
	
	CVPixelBufferRelease(buffer);
	
	return bufferObject;
}

@end
