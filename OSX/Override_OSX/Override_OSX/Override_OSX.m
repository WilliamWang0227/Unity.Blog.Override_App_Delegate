//
// Copyright (c) 2017 eppz! mobile, Gergely Borbás (SP)
//
// http://www.twitter.com/_eppz
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "Override_OSX.h"


@implementation Override_OSX


+(void)load
{
    NSLog(@"[Override_OSX load]");
    [self swizzle];
}

+(void)swizzle
{
    NSLog(@"[Override_OSX swizzle]");
    [self replaceAppDelegateMethod:@selector(applicationDidFinishLaunching:)
                         fromClass:OverrideAppDelegate.class
                  savingOriginalTo:@selector(_original_saved_by_Override_applicationDidFinishLaunching:)];
    
}

+(void)replaceAppDelegateMethod:(SEL) unitySelector
                      fromClass:(Class) overrideAppDelegate
               savingOriginalTo:(SEL) savingOriginalSelector
{
    // The Unity base app controller class (the class name stored in `AppControllerClassName`).
    Class unityAppDelegate = NSClassFromString(@"PlayerAppDelegate");
    
    // See log messages for the sake of this tutorial.
    [EPPZSwizzler setLogging:YES];
    
    // Add empty placholder to Unity app delegate.
    [EPPZSwizzler addInstanceMethod:savingOriginalSelector
                            toClass:unityAppDelegate
                          fromClass:overrideAppDelegate];
    
    // Save the original Unity app delegate implementation into.
    [EPPZSwizzler swapInstanceMethod:savingOriginalSelector
                  withInstanceMethod:unitySelector
                             ofClass:unityAppDelegate];
    
    // Replace Unity app delegate with ours.
    [EPPZSwizzler replaceInstanceMethod:unitySelector
                                ofClass:unityAppDelegate
                              fromClass:overrideAppDelegate];
}


@end
