#import <Foundation/Foundation.h>


@interface CVPOpenGLBuffer : NSObject

+ (instancetype)bufferWithCVOpenGLBuffer:(CVOpenGLBufferRef)buffer;

- (instancetype)initWithCVOpenGLBuffer:(CVOpenGLBufferRef)buffer;

@property (nonatomic, copy, readonly) NSDictionary *attributes;

- (BOOL)attach;
- (BOOL)attachToFace:(GLenum)face level:(GLint)level virtualScreen:(GLint)virtualScreen context:(CGLContextObj)context;
- (void)detach;

- (CVImageBufferRef)CVOpenGLBuffer NS_RETURNS_INNER_POINTER;

@end
