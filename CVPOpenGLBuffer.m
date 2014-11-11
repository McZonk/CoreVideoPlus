#import "CVPOpenGLBuffer.h"


@interface CVPOpenGLBuffer ()
{
@private
	CVOpenGLBufferRef buffer;
}

@end


@implementation CVPOpenGLBuffer

+ (instancetype)bufferWithCVOpenGLBuffer:(CVOpenGLBufferRef)buffer
{
	return [[self alloc] initWithCVOpenGLBuffer:buffer];
}

- (instancetype)initWithCVOpenGLBuffer:(CVOpenGLBufferRef)buffer_
{
	if(buffer_ == NULL)
	{
		return nil;
	}
	
	self = [super init];
	if(self != nil)
	{
		buffer = buffer_;
		CVOpenGLBufferRetain(buffer);
	}
	return self;
}

- (void)dealloc
{
	CVOpenGLBufferRelease(buffer);
}

- (NSDictionary *)attributes
{
	return (__bridge NSDictionary *)CVOpenGLBufferGetAttributes(buffer);
}

- (BOOL)attach
{
	CGLContextObj context = CGLGetCurrentContext();
	
	GLint virtualScreen = 0;
	CGLGetVirtualScreen(context, &virtualScreen);
	
	return [self attachToFace:0 level:0 virtualScreen:virtualScreen context:context];
}

- (BOOL)attachToFace:(GLenum)face level:(GLint)level virtualScreen:(GLint)virtualScreen context:(CGLContextObj)context
{
	CVReturn err = CVOpenGLBufferAttach(buffer, context, face, level, virtualScreen);
	return err == kCVReturnSuccess;
}

- (void)detach
{
	CGLContextObj context = CGLGetCurrentContext();

	CGLClearDrawable(context);
}

- (CVOpenGLBufferRef)CVOpenGLBuffer
{
	return buffer;
}

@end
