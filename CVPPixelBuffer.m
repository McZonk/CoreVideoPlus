#import "CVPPixelBuffer.h"


@interface CVPPixelBuffer ()
{
@private
	CVPixelBufferRef buffer;
}
@end


@implementation CVPPixelBuffer

+ (instancetype)bufferWithCVPixelBuffer:(CVPixelBufferRef)buffer
{
	return [[self alloc] initWithCVPixelBuffer:buffer];
}

- (instancetype)initWithCVPixelBuffer:(CVPixelBufferRef)buffer_
{
	if (buffer_ == nil)
	{
		return nil;
	}
	
	self = [super init];
	if(self != nil)
	{
		buffer = buffer_;
		CVPixelBufferRetain(buffer);
	}
	return self;
}

- (void)dealloc
{
	CVPixelBufferRelease(buffer);
}

- (CVPixelBufferRef)CVPixelBuffer
{
	return buffer;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@: %p %@>", self.class, self, buffer];
}

@end
