#import "CVPOpenGLTexture.h"

#import <OpenGL/gl3.h>


@interface CVPOpenGLTexture ()
{
@private
	CVOpenGLTextureRef texture;
}

@end


@implementation CVPOpenGLTexture

+ (instancetype)textureWithCVOpenGLTexture:(CVOpenGLTextureRef)texture
{
	return [[self alloc] initWithCVOpenGLTexture:texture];
}

- (instancetype)initWithCVOpenGLTexture:(CVOpenGLTextureRef)texture_
{
	if(texture_ == NULL)
	{
		return nil;
	}
	
	self = [super init];
	if(self != nil)
	{
		texture = texture_;
		CVOpenGLTextureRetain(texture);
		
		glpTextureSetDefaults(self.GLTarget, self.GLTexture);
	}
	return self;
}

- (void)dealloc
{
	CVOpenGLTextureRelease(texture);
}

- (GLenum)GLTarget
{
	return CVOpenGLTextureGetTarget(texture);
}

- (GLuint)GLTexture
{
	return CVOpenGLTextureGetName(texture);
}

- (void)bind
{
	glBindTexture(self.GLTarget, self.GLTexture);
}

- (void)bindToUnit:(GLenum)unit
{
	glpActiveTexture(unit);
	[self bind];
}

- (void)unbind
{
	glBindTexture(self.GLTarget, 0);
}

- (CVOpenGLTextureRef)CVOpenGLTexture NS_RETURNS_INNER_POINTER
{
	return texture;
}

- (void)getCleanTextureCoordinates:(GLfloat [8])textureCoordinates
{
	CVOpenGLTextureGetCleanTexCoords(texture, textureCoordinates+0, textureCoordinates+2, textureCoordinates+4, textureCoordinates+6);
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"<%@: %p | %@>", [self class], self, texture];
}

@end
