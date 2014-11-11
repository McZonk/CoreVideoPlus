#import "CVPOpenGLTextureCache+CMSampleBuffer.h"


@implementation CVPOpenGLTextureCache (CMSampleBuffer)

- (CVPOpenGLTexture *)textureWithSampleBuffer:(CMSampleBufferRef)sampleBuffer error:(NSError **)error
{
	CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	if(pixelBuffer == nil)
	{
		// TODO:
		return nil;
	}
	
	return [self textureWithPixelBuffer:pixelBuffer error:error];
}

@end
