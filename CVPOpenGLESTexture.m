#import "CVPOpenGLESTexture.h"


@interface CVPOpenGLESTexture ()
{
@private
	CVOpenGLESTextureRef texture;
}

@end


@implementation CVPOpenGLESTexture

+ (instancetype)textureWithCVOpenGLESTexture:(CVOpenGLESTextureRef)texture
{
	return [[self alloc] initWithCVOpenGLESTexture:texture];
}

- (instancetype)initWithCVOpenGLESTexture:(CVOpenGLESTextureRef)texture_
{
	if(texture_ == NULL)
	{
		return nil;
	}
	
	self = [super init];
	if(self != nil) {
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
	return CVOpenGLESTextureGetTarget(texture);
}

- (GLuint)GLTexture
{
	return CVOpenGLESTextureGetName(texture);
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

- (NSString*)description {
	return [NSString stringWithFormat:@"<%@: %p | %@>", [self class], self, texture];
}

@end
