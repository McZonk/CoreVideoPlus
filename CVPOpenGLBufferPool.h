#import <CoreVideo/CoreVideo.h>
#import <Foundation/Foundation.h>


@class CVPOpenGLBuffer;


@interface CVPOpenGLBufferPool : NSObject

- (instancetype)initWithMinimumBufferCount:(NSUInteger)minimumBufferCount maximumBufferAge:(NSTimeInterval)maximumBufferAge width:(GLint)width height:(GLint)height target:(GLenum)target format:(GLenum)format maximumMipmapLevel:(GLint)maximumMipmapLevel error:(NSError **)error;

- (instancetype)initWithPoolAttributes:(NSDictionary *)poolAttributes bufferAttributes:(NSDictionary *)bufferAttributes error:(NSError **)error;

- (CVOpenGLBufferRef)createBufferWithError:(NSError **)error;

- (CVPOpenGLBuffer *)bufferWithError:(NSError **)error;

@end
