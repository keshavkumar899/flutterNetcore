#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SmartechAppinboxPlugin.h"

FOUNDATION_EXPORT double smartech_appinboxVersionNumber;
FOUNDATION_EXPORT const unsigned char smartech_appinboxVersionString[];

