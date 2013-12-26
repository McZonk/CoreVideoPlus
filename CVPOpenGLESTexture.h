#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

#import <OpenGLPlus/GLPTexture.h>


@interface CVPOpenGLESTexture : NSObject <GLPTexture>

+ (instancetype)textureWithCVOpenGLESTexture:(CVOpenGLESTextureRef)texture;

- (instancetype)initWithCVOpenGLESTexture:(CVOpenGLESTextureRef)texture;

@end
