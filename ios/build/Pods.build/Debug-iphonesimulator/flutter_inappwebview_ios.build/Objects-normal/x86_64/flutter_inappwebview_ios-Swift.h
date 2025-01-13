// Generated by Apple Swift version 6.0.3 effective-5.10 (swiftlang-6.0.3.1.10 clang-1600.0.30.1)
#ifndef FLUTTER_INAPPWEBVIEW_IOS_SWIFT_H
#define FLUTTER_INAPPWEBVIEW_IOS_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#if defined(__OBJC__)
#include <Foundation/Foundation.h>
#endif
#if defined(__cplusplus)
#include <cstdint>
#include <cstddef>
#include <cstdbool>
#include <cstring>
#include <stdlib.h>
#include <new>
#include <type_traits>
#else
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <string.h>
#endif
#if defined(__cplusplus)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnon-modular-include-in-framework-module"
#if defined(__arm64e__) && __has_include(<ptrauth.h>)
# include <ptrauth.h>
#else
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wreserved-macro-identifier"
# ifndef __ptrauth_swift_value_witness_function_pointer
#  define __ptrauth_swift_value_witness_function_pointer(x)
# endif
# ifndef __ptrauth_swift_class_method_pointer
#  define __ptrauth_swift_class_method_pointer(x)
# endif
#pragma clang diagnostic pop
#endif
#pragma clang diagnostic pop
#endif

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...) 
# endif
#endif
#if !defined(SWIFT_RUNTIME_NAME)
# if __has_attribute(objc_runtime_name)
#  define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
# else
#  define SWIFT_RUNTIME_NAME(X) 
# endif
#endif
#if !defined(SWIFT_COMPILE_NAME)
# if __has_attribute(swift_name)
#  define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
# else
#  define SWIFT_COMPILE_NAME(X) 
# endif
#endif
#if !defined(SWIFT_METHOD_FAMILY)
# if __has_attribute(objc_method_family)
#  define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
# else
#  define SWIFT_METHOD_FAMILY(X) 
# endif
#endif
#if !defined(SWIFT_NOESCAPE)
# if __has_attribute(noescape)
#  define SWIFT_NOESCAPE __attribute__((noescape))
# else
#  define SWIFT_NOESCAPE 
# endif
#endif
#if !defined(SWIFT_RELEASES_ARGUMENT)
# if __has_attribute(ns_consumed)
#  define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
# else
#  define SWIFT_RELEASES_ARGUMENT 
# endif
#endif
#if !defined(SWIFT_WARN_UNUSED_RESULT)
# if __has_attribute(warn_unused_result)
#  define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
# else
#  define SWIFT_WARN_UNUSED_RESULT 
# endif
#endif
#if !defined(SWIFT_NORETURN)
# if __has_attribute(noreturn)
#  define SWIFT_NORETURN __attribute__((noreturn))
# else
#  define SWIFT_NORETURN 
# endif
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA 
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA 
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA 
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif
#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif
#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER 
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility) 
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED_OBJC)
# if __has_feature(attribute_diagnose_if_objc)
#  define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
# else
#  define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
# endif
#endif
#if defined(__OBJC__)
#if !defined(IBSegueAction)
# define IBSegueAction 
#endif
#endif
#if !defined(SWIFT_EXTERN)
# if defined(__cplusplus)
#  define SWIFT_EXTERN extern "C"
# else
#  define SWIFT_EXTERN extern
# endif
#endif
#if !defined(SWIFT_CALL)
# define SWIFT_CALL __attribute__((swiftcall))
#endif
#if !defined(SWIFT_INDIRECT_RESULT)
# define SWIFT_INDIRECT_RESULT __attribute__((swift_indirect_result))
#endif
#if !defined(SWIFT_CONTEXT)
# define SWIFT_CONTEXT __attribute__((swift_context))
#endif
#if !defined(SWIFT_ERROR_RESULT)
# define SWIFT_ERROR_RESULT __attribute__((swift_error_result))
#endif
#if defined(__cplusplus)
# define SWIFT_NOEXCEPT noexcept
#else
# define SWIFT_NOEXCEPT 
#endif
#if !defined(SWIFT_C_INLINE_THUNK)
# if __has_attribute(always_inline)
# if __has_attribute(nodebug)
#  define SWIFT_C_INLINE_THUNK inline __attribute__((always_inline)) __attribute__((nodebug))
# else
#  define SWIFT_C_INLINE_THUNK inline __attribute__((always_inline))
# endif
# else
#  define SWIFT_C_INLINE_THUNK inline
# endif
#endif
#if defined(_WIN32)
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL __declspec(dllimport)
#endif
#else
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL 
#endif
#endif
#if defined(__OBJC__)
#if __has_feature(objc_modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import AuthenticationServices;
@import CoreFoundation;
@import Flutter;
@import Foundation;
@import ObjectiveC;
@import SafariServices;
@import UIKit;
@import WebKit;
#endif

#endif
#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"
#pragma clang diagnostic ignored "-Wunsafe-buffer-usage"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="flutter_inappwebview_ios",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

#if defined(__OBJC__)


SWIFT_CLASS("_TtC24flutter_inappwebview_ios25FlutterMethodCallDelegate")
@interface FlutterMethodCallDelegate : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios15ChannelDelegate")
@interface ChannelDelegate : FlutterMethodCallDelegate
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios26ChromeSafariBrowserManager")
@interface ChromeSafariBrowserManager : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios19ClientCertChallenge")
@interface ClientCertChallenge : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios18ClientCertResponse")
@interface ClientCertResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios18CreateWindowAction")
@interface CreateWindowAction : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios18CredentialDatabase")
@interface CredentialDatabase : ChannelDelegate
@end

@class WKWebView;
@protocol WKURLSchemeTask;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios19CustomSchemeHandler") SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface CustomSchemeHandler : NSObject <WKURLSchemeHandler>
- (void)webView:(WKWebView * _Nonnull)webView startURLSchemeTask:(id <WKURLSchemeTask> _Nonnull)urlSchemeTask;
- (void)webView:(WKWebView * _Nonnull)webView stopURLSchemeTask:(id <WKURLSchemeTask> _Nonnull)urlSchemeTask;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios20CustomSchemeResponse")
@interface CustomSchemeResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios25CustomUIPrintPageRenderer")
@interface CustomUIPrintPageRenderer : UIPrintPageRenderer
@property (nonatomic, readonly) NSInteger numberOfPages;
- (UIPrintRenderingQuality)currentRenderingQualityForRequestedRenderingQuality:(UIPrintRenderingQuality)requestedRenderingQuality SWIFT_WARN_UNUSED_RESULT SWIFT_AVAILABILITY(ios,introduced=14.5);
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios20DownloadStartRequest")
@interface DownloadStartRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios30FindInteractionChannelDelegate")
@interface FindInteractionChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios25FindInteractionController")
@interface FindInteractionController : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios11FindSession")
@interface FindSession : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end



@class UIView;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios24FlutterWebViewController")
@interface FlutterWebViewController : NSObject <FlutterPlatformView>
- (UIView * _Nonnull)view SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@protocol FlutterMessageCodec;
@protocol NSObject;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios21FlutterWebViewFactory")
@interface FlutterWebViewFactory : NSObject <FlutterPlatformViewFactory>
- (id <FlutterMessageCodec, NSObject> _Nonnull)createArgsCodec SWIFT_WARN_UNUSED_RESULT;
- (id <FlutterPlatformView> _Nonnull)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios27HeadlessInAppWebViewManager")
@interface HeadlessInAppWebViewManager : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios30HeadlessWebViewChannelDelegate")
@interface HeadlessWebViewChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios13HitTestResult")
@interface HitTestResult : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios16HttpAuthResponse")
@interface HttpAuthResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios27HttpAuthenticationChallenge")
@interface HttpAuthenticationChallenge : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios27InAppBrowserChannelDelegate")
@interface InAppBrowserChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios19InAppBrowserManager")
@interface InAppBrowserManager : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios20InAppBrowserMenuItem")
@interface InAppBrowserMenuItem : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class UIViewController;
@class NSString;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios32InAppBrowserNavigationController")
@interface InAppBrowserNavigationController : UINavigationController
- (nonnull instancetype)initWithNavigationBarClass:(Class _Nullable)navigationBarClass toolbarClass:(Class _Nullable)toolbarClass OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=5.0);
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UISearchBar;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios29InAppBrowserWebViewController")
@interface InAppBrowserWebViewController : UIViewController <UIScrollViewDelegate, UISearchBarDelegate>
- (void)loadView;
- (void)viewDidLoad;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)searchBarSearchButtonClicked:(UISearchBar * _Nonnull)searchBar;
- (void)reload;
- (void)share;
- (void)close;
- (void)goBack;
- (void)goForward;
- (void)goBackOrForwardWithSteps:(NSInteger)steps;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIGestureRecognizer;
@class UIEvent;
@protocol UIMenuBuilder;
@protocol UIEditMenuInteractionAnimating;
@class WKSecurityOrigin;
@class WKFrameInfo;
@class WKNavigationAction;
@class WKWebpagePreferences;
@class WKDownload;
@class NSURLResponse;
@class NSURL;
@class WKNavigationResponse;
@class WKNavigation;
@class NSURLAuthenticationChallenge;
@class NSURLCredential;
@class UIScrollView;
@class WKWebViewConfiguration;
@class WKWindowFeatures;
@class WKUserContentController;
@class WKScriptMessage;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios12InAppWebView")
@interface InAppWebView : WKWebView <UIGestureRecognizerDelegate, UIScrollViewDelegate, WKDownloadDelegate, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>
@property (nonatomic) CGRect frame;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (BOOL)gestureRecognizer:(UIGestureRecognizer * _Nonnull)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer * _Nonnull)otherGestureRecognizer SWIFT_WARN_UNUSED_RESULT;
- (UIView * _Nullable)hitTest:(CGPoint)point withEvent:(UIEvent * _Nullable)event SWIFT_WARN_UNUSED_RESULT;
- (void)buildMenuWithBuilder:(id <UIMenuBuilder> _Nonnull)builder SWIFT_AVAILABILITY(ios,introduced=13.0);
- (void)webView:(WKWebView * _Nonnull)webView willPresentEditMenuWithAnimator:(id <UIEditMenuInteractionAnimating> _Nonnull)animator SWIFT_AVAILABILITY(ios,introduced=16.4);
- (void)webView:(WKWebView * _Nonnull)webView willDismissEditMenuWithAnimator:(id <UIEditMenuInteractionAnimating> _Nonnull)animator SWIFT_AVAILABILITY(ios,introduced=16.4);
- (BOOL)canPerformAction:(SEL _Nonnull)action withSender:(id _Nullable)sender SWIFT_WARN_UNUSED_RESULT;
- (void)observeValueForKeyPath:(NSString * _Nullable)keyPath ofObject:(id _Nullable)object change:(NSDictionary<NSKeyValueChangeKey, id> * _Nullable)change context:(void * _Nullable)context;
- (void)evaluateJavaScript:(NSString * _Nonnull)javaScriptString completionHandler:(void (^ _Nullable)(id _Nullable, NSError * _Nullable))completionHandler;
- (void)webView:(WKWebView * _Nonnull)webView requestMediaCapturePermissionForOrigin:(WKSecurityOrigin * _Nonnull)origin initiatedByFrame:(WKFrameInfo * _Nonnull)frame type:(WKMediaCaptureType)type decisionHandler:(void (^ _Nonnull)(WKPermissionDecision))decisionHandler SWIFT_AVAILABILITY(ios,introduced=15.0);
- (void)webView:(WKWebView * _Nonnull)webView requestDeviceOrientationAndMotionPermissionForOrigin:(WKSecurityOrigin * _Nonnull)origin initiatedByFrame:(WKFrameInfo * _Nonnull)frame decisionHandler:(void (^ _Nonnull)(WKPermissionDecision))decisionHandler SWIFT_AVAILABILITY(ios,introduced=15.0);
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationAction:(WKNavigationAction * _Nonnull)navigationAction preferences:(WKWebpagePreferences * _Nonnull)preferences decisionHandler:(void (^ _Nonnull)(WKNavigationActionPolicy, WKWebpagePreferences * _Nonnull))decisionHandler SWIFT_AVAILABILITY(ios,introduced=13.0);
- (void)download:(WKDownload * _Nonnull)download decideDestinationUsingResponse:(NSURLResponse * _Nonnull)response suggestedFilename:(NSString * _Nonnull)suggestedFilename completionHandler:(void (^ _Nonnull)(NSURL * _Nullable))completionHandler SWIFT_AVAILABILITY(ios,introduced=14.5);
- (void)webView:(WKWebView * _Nonnull)webView navigationResponse:(WKNavigationResponse * _Nonnull)navigationResponse didBecomeDownload:(WKDownload * _Nonnull)download SWIFT_AVAILABILITY(ios,introduced=14.5);
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationAction:(WKNavigationAction * _Nonnull)navigationAction decisionHandler:(void (^ _Nonnull)(WKNavigationActionPolicy))decisionHandler;
- (void)webView:(WKWebView * _Nonnull)webView decidePolicyForNavigationResponse:(WKNavigationResponse * _Nonnull)navigationResponse decisionHandler:(void (^ _Nonnull)(WKNavigationResponsePolicy))decisionHandler;
- (void)webView:(WKWebView * _Nonnull)webView didStartProvisionalNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didFinishNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)view didFailProvisionalNavigation:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)error;
- (void)webView:(WKWebView * _Nonnull)webView didFailNavigation:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)error;
- (void)webView:(WKWebView * _Nonnull)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge completionHandler:(void (^ _Nonnull)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;
- (void)webView:(WKWebView * _Nonnull)webView runJavaScriptAlertPanelWithMessage:(NSString * _Nonnull)message initiatedByFrame:(WKFrameInfo * _Nonnull)frame completionHandler:(void (^ _Nonnull)(void))completionHandler;
- (void)webView:(WKWebView * _Nonnull)webView runJavaScriptConfirmPanelWithMessage:(NSString * _Nonnull)message initiatedByFrame:(WKFrameInfo * _Nonnull)frame completionHandler:(void (^ _Nonnull)(BOOL))completionHandler;
- (void)webView:(WKWebView * _Nonnull)webView runJavaScriptTextInputPanelWithPrompt:(NSString * _Nonnull)message defaultText:(NSString * _Nullable)defaultValue initiatedByFrame:(WKFrameInfo * _Nonnull)frame completionHandler:(void (^ _Nonnull)(NSString * _Nullable))completionHandler;
- (void)scrollViewDidZoom:(UIScrollView * _Nonnull)scrollView;
- (WKWebView * _Nullable)webView:(WKWebView * _Nonnull)webView createWebViewWithConfiguration:(WKWebViewConfiguration * _Nonnull)configuration forNavigationAction:(WKNavigationAction * _Nonnull)navigationAction windowFeatures:(WKWindowFeatures * _Nonnull)windowFeatures SWIFT_WARN_UNUSED_RESULT;
- (void)webView:(WKWebView * _Nonnull)webView authenticationChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge shouldAllowDeprecatedTLS:(void (^ _Nonnull)(BOOL))decisionHandler;
- (void)webViewDidClose:(WKWebView * _Nonnull)webView;
- (void)webViewWebContentProcessDidTerminate:(WKWebView * _Nonnull)webView;
- (void)webView:(WKWebView * _Nonnull)webView didCommitNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation * _Null_unspecified)navigation;
- (void)userContentController:(WKUserContentController * _Nonnull)userContentController didReceiveScriptMessage:(WKScriptMessage * _Nonnull)message;
@property (nonatomic, readonly, strong) UIView * _Nullable inputAccessoryView;
- (nonnull instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration * _Nonnull)configuration SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios19InAppWebViewManager")
@interface InAppWebViewManager : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios15JsAlertResponse")
@interface JsAlertResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios17JsConfirmResponse")
@interface JsConfirmResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios16JsPromptResponse")
@interface JsPromptResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios11LeakAvoider")
@interface LeakAvoider : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios15MyCookieManager") SWIFT_AVAILABILITY(ios,introduced=11.0)
@interface MyCookieManager : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios19MyWebStorageManager") SWIFT_AVAILABILITY(ios,introduced=9.0)
@interface MyWebStorageManager : ChannelDelegate
@end



SWIFT_CLASS("_TtC24flutter_inappwebview_ios17PermissionRequest")
@interface PermissionRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios18PermissionResponse")
@interface PermissionResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios12PlatformUtil")
@interface PlatformUtil : ChannelDelegate
@end

@class WKContentWorld;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios10UserScript")
@interface UserScript : WKUserScript
- (nonnull instancetype)initWithSource:(NSString * _Nonnull)source injectionTime:(WKUserScriptInjectionTime)injectionTime forMainFrameOnly:(BOOL)forMainFrameOnly OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithSource:(NSString * _Nonnull)source injectionTime:(WKUserScriptInjectionTime)injectionTime forMainFrameOnly:(BOOL)forMainFrameOnly inContentWorld:(WKContentWorld * _Nonnull)contentWorld OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=14.0);
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios12PluginScript")
@interface PluginScript : UserScript
- (nonnull instancetype)initWithSource:(NSString * _Nonnull)source injectionTime:(WKUserScriptInjectionTime)injectionTime forMainFrameOnly:(BOOL)forMainFrameOnly OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithSource:(NSString * _Nonnull)source injectionTime:(WKUserScriptInjectionTime)injectionTime forMainFrameOnly:(BOOL)forMainFrameOnly inContentWorld:(WKContentWorld * _Nonnull)contentWorld OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=14.0);
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios15PrintAttributes")
@interface PrintAttributes : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios23PrintJobChannelDelegate")
@interface PrintJobChannelDelegate : ChannelDelegate
@end

@class UIPrintInteractionController;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios18PrintJobController")
@interface PrintJobController : NSObject <UIPrintInteractionControllerDelegate>
- (void)printInteractionControllerWillStartJob:(UIPrintInteractionController * _Nonnull)printInteractionController;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios12PrintJobInfo")
@interface PrintJobInfo : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios15PrintJobManager")
@interface PrintJobManager : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios28PullToRefreshChannelDelegate")
@interface PullToRefreshChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios20PullToRefreshControl")
@interface PullToRefreshControl : UIRefreshControl
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder SWIFT_UNAVAILABLE;
- (void)updateShouldCallOnRefresh;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
@end

@class UIActivity;
@class SFSafariViewControllerConfiguration;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios20SafariViewController") SWIFT_AVAILABILITY(ios,introduced=9.0)
@interface SafariViewController : SFSafariViewController <SFSafariViewControllerDelegate>
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)safariViewControllerDidFinish:(SFSafariViewController * _Nonnull)controller;
- (void)safariViewController:(SFSafariViewController * _Nonnull)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully;
- (NSArray<UIActivity *> * _Nonnull)safariViewController:(SFSafariViewController * _Nonnull)controller activityItemsForURL:(NSURL * _Nonnull)URL title:(NSString * _Nullable)title SWIFT_WARN_UNUSED_RESULT;
- (void)safariViewController:(SFSafariViewController * _Nonnull)controller initialLoadDidRedirectToURL:(NSURL * _Nonnull)url;
- (void)safariViewControllerWillOpenInBrowser:(SFSafariViewController * _Nonnull)controller;
- (nonnull instancetype)initWithURL:(NSURL * _Nonnull)URL configuration:(SFSafariViewControllerConfiguration * _Nonnull)configuration SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithURL:(NSURL * _Nonnull)URL entersReaderIfAvailable:(BOOL)entersReaderIfAvailable SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios35SafariViewControllerChannelDelegate")
@interface SafariViewControllerChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios23ServerTrustAuthResponse")
@interface ServerTrustAuthResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios20ServerTrustChallenge")
@interface ServerTrustChallenge : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios6Size2D")
@interface Size2D : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios14SslCertificate")
@interface SslCertificate : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios8SslError")
@interface SslError : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@protocol FlutterPluginRegistrar;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios18SwiftFlutterPlugin")
@interface SwiftFlutterPlugin : NSObject <FlutterPlugin>
+ (void)registerWithRegistrar:(id <FlutterPluginRegistrar> _Nonnull)registrar;
- (void)detachFromEngineForRegistrar:(id <FlutterPluginRegistrar> _Nonnull)registrar;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


















@class ASWebAuthenticationSession;

SWIFT_CLASS("_TtC24flutter_inappwebview_ios24WebAuthenticationSession")
@interface WebAuthenticationSession : NSObject <ASWebAuthenticationPresentationContextProviding>
- (ASPresentationAnchor _Nonnull)presentationAnchorForWebAuthenticationSession:(ASWebAuthenticationSession * _Nonnull)session SWIFT_WARN_UNUSED_RESULT SWIFT_AVAILABILITY(ios,introduced=12.0);
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios39WebAuthenticationSessionChannelDelegate")
@interface WebAuthenticationSessionChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios31WebAuthenticationSessionManager")
@interface WebAuthenticationSessionManager : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios10WebMessage")
@interface WebMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios17WebMessageChannel")
@interface WebMessageChannel : FlutterMethodCallDelegate
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios32WebMessageChannelChannelDelegate")
@interface WebMessageChannelChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios18WebMessageListener")
@interface WebMessageListener : FlutterMethodCallDelegate
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios33WebMessageListenerChannelDelegate")
@interface WebMessageListenerChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios14WebMessagePort")
@interface WebMessagePort : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios16WebResourceError")
@interface WebResourceError : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios18WebResourceRequest")
@interface WebResourceRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios19WebResourceResponse")
@interface WebResourceResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios22WebViewChannelDelegate")
@interface WebViewChannelDelegate : ChannelDelegate
@end


SWIFT_CLASS("_TtC24flutter_inappwebview_ios16WebViewTransport")
@interface WebViewTransport : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

#endif
#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#if defined(__cplusplus)
#endif
#pragma clang diagnostic pop
#endif
