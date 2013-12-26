#import "GLPPixelformat+CVPPixelformat.h"

GLPPixelformat glpPixelformatFromCVPixelBuffer(CVPixelBufferRef pixelBuffer, size_t plane)
{
	const OSType formatType = CVPixelBufferGetPixelFormatType(pixelBuffer);
	
	switch(formatType)
	{
		case kCVPixelFormatType_32RGBA :
			return GLPPixelformatRGBA8888;
			
		case kCVPixelFormatType_32BGRA :
			return GLPPixelformatBGRA8888;
			
		case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange:
		case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:
			if(plane == 0)
			{
				return GLPPixelformatRed8;
			} else {
				return GLPPixelformatRedGreen8;
			}
			
		default:
			return GLPPixelformatUnknown;
	}
}
