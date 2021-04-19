#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Prod key AIzaSyBhgphoSDhLGeFIgvzwYSSizM_xW4_3HAk
    //Dev key AIzaSyAMRNqkZCuD7CYSWQzcvNWxCvOJ44lNJ3U
  [GMSServices provideAPIKey:@"AIzaSyAMRNqkZCuD7CYSWQzcvNWxCvOJ44lNJ3U"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
