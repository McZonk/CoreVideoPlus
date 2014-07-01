
#include <TargetConditionals.h>


#include "GLPPixelformat+CVPPixelformat.h"

#ifdef __OBJC__

#import "NSError+CVPError.h"

#endif


#if defined(TARGET_OS_MAC) && (TARGET_OS_MAC > 0)

#ifdef __OBJC__

#endif  /* __OBJC__ */

#elif defined(TARGET_OS_IPHONE) && (TARGET_OS_IPHONE > 0)


#ifdef __OBJC__

#import "CVPOpenGLESTexture.h"
#import "CVPOpenGLESTextureCache.h"

#endif /* __OBJC__ */


#endif

