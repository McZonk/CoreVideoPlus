#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

#import <OpenGLPlus/GLPTexture.h>


@interface CVPOpenGLTexture : NSObject <GLPTexture>

+ (instancetype)textureWithCVOpenGLTexture:(CVOpenGLTextureRef)texture;

- (instancetype)initWithCVOpenGLTexture:(CVOpenGLTextureRef)texture;

- (CVOpenGLTextureRef)CVOpenGLTexture NS_RETURNS_INNER_POINTER;

- (void)getCleanTextureCoordinates:(GLfloat [8])textureCoordinates;

@end
