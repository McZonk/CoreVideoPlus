#import <Foundation/Foundation.h>
#import <CoreVideo/CoreVideo.h>

#import <OpenGLPlus/GLPTexture.h>


@interface CVPOpenGLESTexture : NSObject <GLPTexture>

+ (instancetype)textureWithCVOpenGLESTexture:(CVOpenGLESTextureRef)texture;

- (instancetype)initWithCVOpenGLESTexture:(CVOpenGLESTextureRef)texture;

@end
