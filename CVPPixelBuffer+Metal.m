#import "CVPPixelBuffer+Metal.h"

#if COREVIDEO_SUPPORTS_METAL

static MTLPixelFormat convertPixelFormat(OSType pixelFormat, size_t planeIndex)
{
	if(planeIndex == 0)
	{
		switch(pixelFormat)
		{
			case kCVPixelFormatType_32BGRA:
				return MTLPixelFormatBGRA8Unorm;
			
			case kCVPixelFormatType_32RGBA:
				return MTLPixelFormatRGBA8Unorm;
			
			case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:
			case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange:
				return MTLPixelFormatR8Unorm;
			
			case kCVPixelFormatType_422YpCbCr8_yuvs:
				return MTLPixelFormatGBGR422;
		}
	}
	else if(planeIndex == 1)
	{
		switch(pixelFormat)
		{
			case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:
			case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange:
				return MTLPixelFormatRG8Unorm;
		}
	}
	
	return MTLPixelFormatInvalid;
}

MTLPixelFormat CVPPixelBufferGetMetalPixelFormat(CVPixelBufferRef pixelBuffer)
{
	OSType pixelFormat = CVPixelBufferGetPixelFormatType(pixelBuffer);
	return convertPixelFormat(pixelFormat, 0);
}

MTLPixelFormat CVPPixelBufferGetMetalPixelFormatOfPlane(CVPixelBufferRef pixelBuffer, size_t planeIndex)
{
	OSType pixelFormat = CVPixelBufferGetPixelFormatType(pixelBuffer);
	return convertPixelFormat(pixelFormat, planeIndex);
}

#endif /* COREVIDEO_SUPPORTS_METAL */
