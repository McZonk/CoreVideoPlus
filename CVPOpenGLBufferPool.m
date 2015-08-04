#import "CVPOpenGLBufferPool.h"

#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>
#import <OpenGL/OpenGL.h>

#import "CVPOpenGLBuffer.h"
#import "NSError+CVPError.h"


@interface CVPOpenGLBufferPool ()
{
@private
	CVOpenGLBufferPoolRef bufferPool;
}

@end


@implementation CVPOpenGLBufferPool

- (instancetype)initWithMinimumBufferCount:(NSUInteger)minimumBufferCount maximumBufferAge:(NSTimeInterval)maximumBufferAge width:(int32_t)width height:(int32_t)height target:(GLenum)target format:(GLenum)format maximumMipmapLevel:(GLint)maximumMipmapLevel error:(NSError **)error
{
	NSDictionary *poolAttributes = @{
		(__bridge NSString *)kCVOpenGLBufferPoolMinimumBufferCountKey: @(minimumBufferCount),
		(__bridge NSString *)kCVOpenGLBufferPoolMaximumBufferAgeKey: @(maximumBufferAge),
	};
	
	NSDictionary *bufferAttributes = @{
		(__bridge NSString *)kCVOpenGLBufferWidth: @(width),
		(__bridge NSString *)kCVOpenGLBufferHeight: @(height),
		(__bridge NSString *)kCVOpenGLBufferTarget: @(target),
		(__bridge NSString *)kCVOpenGLBufferInternalFormat: @(format),
		(__bridge NSString *)kCVOpenGLBufferMaximumMipmapLevel: @(maximumMipmapLevel),
	};
	
	return [self initWithPoolAttributes:poolAttributes bufferAttributes:bufferAttributes error:error];
}

- (instancetype)initWithPoolAttributes:(NSDictionary *)poolAttributes bufferAttributes:(NSDictionary *)bufferAttributes error:(NSError **)error
{
	self = [super init];
	if(self != nil)
	{
		CVReturn err = CVOpenGLBufferPoolCreate(NULL, (__bridge CFDictionaryRef)poolAttributes, (__bridge CFDictionaryRef)bufferAttributes, &bufferPool);
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
	CVOpenGLBufferPoolRelease(bufferPool);
}

- (CVOpenGLBufferRef)createBufferWithError:(NSError **)error
{
	CVOpenGLBufferRef buffer = NULL;
	CVReturn err = CVOpenGLBufferPoolCreateOpenGLBuffer(NULL, bufferPool, &buffer);
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

- (CVPOpenGLBuffer *)bufferWithError:(NSError **)error
{
	CVOpenGLBufferRef buffer = [self createBufferWithError:error];
	if (buffer == NULL)
	{
		return NULL;
	}
	
	CVPOpenGLBuffer *bufferObject = [[CVPOpenGLBuffer alloc] initWithCVOpenGLBuffer:buffer];
	
	CVOpenGLBufferRelease(buffer);
	
	return bufferObject;
}

@end
