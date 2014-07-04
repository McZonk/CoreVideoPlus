
#include <TargetConditionals.h>

#include <CoreVideoPlus/GLPPixelformat+CVPPixelformat.h>


#ifdef __OBJC__

#import <CoreVideoPlus/NSError+CVPError.h>

#endif


#if defined(TARGET_OS_MAC) && (TARGET_OS_MAC > 0)

#ifdef __OBJC__

#import <CoreVideoPlus/CVPOpenGLTexture.h>
#import <CoreVideoPlus/CVPOpenGLTextureCache.h>

#endif  /* __OBJC__ */

#elif defined(TARGET_OS_IPHONE) && (TARGET_OS_IPHONE > 0)


#ifdef __OBJC__

#import <CoreVideoPlus/CVPOpenGLESTexture.h>
#import <CoreVideoPlus/CVPOpenGLESTextureCache.h>

#endif /* __OBJC__ */


#endif

