#import "CVPOpenGLTextureCache.h"

#import <CoreMedia/CoreMedia.h>


@interface CVPOpenGLTextureCache (CMSampleBuffer)

- (CVPOpenGLTexture *)textureWithSampleBuffer:(CMSampleBufferRef)sampleBuffer error:(NSError **)error;

@end
