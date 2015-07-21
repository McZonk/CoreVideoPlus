#import "CVPOpenGLTextureCache+CMSampleBuffer.h"


@implementation CVPOpenGLTextureCache (CMSampleBuffer)

- (CVPOpenGLTexture *)textureWithSampleBuffer:(CMSampleBufferRef)sampleBuffer error:(NSError **)error
{
	CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
	if(imageBuffer == nil)
	{
		// TODO:
		return nil;
	}
	
	return [self textureWithImageBuffer:imageBuffer error:error];
}

@end
