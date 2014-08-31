#import <CoreVideo/CoreVideo.h>
#import <Metal/Metal.h>

#if defined(__OBJC__) && COREVIDEO_SUPPORTS_METAL

MTLPixelFormat CVPPixelBufferGetMetalPixelFormat(CVPixelBufferRef pixelBuffer);

MTLPixelFormat CVPPixelBufferGetMetalPixelFormatOfPlane(CVPixelBufferRef pixelBuffer, size_t planeIndex);

#endif /* __OBJC__ && COREVIDEO_SUPPORTS_METAL */
