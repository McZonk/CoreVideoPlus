#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

#import <OpenGLPlus/GLPTexture.h>


@interface CVPOpenGLTexture : NSObject <GLPTexture>

+ (instancetype)textureWithCVOpenGLTexture:(CVOpenGLTextureRef)texture;

- (instancetype)initWithCVOpenGLTexture:(CVOpenGLTextureRef)texture;

@end
