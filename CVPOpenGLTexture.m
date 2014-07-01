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
		
		glpTextureSetDefaults(self.GLTarget, self.GLTexture);
	}
	return self;
}

- (void)dealloc
{
	if(texture != NULL)
	{
		CFRelease(texture), texture = NULL;
	}
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

- (NSString*)description
{
	return [NSString stringWithFormat:@"<%@: %p | %@>", [self class], self, texture];
}

@end
