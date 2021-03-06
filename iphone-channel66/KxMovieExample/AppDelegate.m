//
//  AppDelegate.m
//  kxmovieapp
//
//  Created by Kolyvan on 11.10.12.
//  Copyright (c) 2012 Konstantin Boukreev . All rights reserved.
//
//  https://github.com/kolyvan/kxmovie
//  this file is part of KxMovie
//  KxMovie is licenced under the LGPL v3, see lgpl-3.0.txt
//#define TESTING 0
#import "AppDelegate.h"
#import "MainViewController.h"
#import "GAI.h"
#ifdef TESTING
#import "TestFlight.h"
#endif
//#import "Parse/Parse.h"
#import "BBmessagesTableViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginButton.h>
#import "Firebase.h"

#import <UserNotifications/UserNotifications.h>
#import <CoreData/CoreData.h>

#import "DataStore.h"
#import <OneSignal/OneSignal.h>
#import "IQKeyboardManager.h"
#import "KxMovieExample-Swift.h"

@implementation AppDelegate
//- (NSManagedObjectContext *)managedObjectContext
//{
//    if(self._context == nil)
//    {
//        return self._context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSConfinementConcurrencyType];
//    }
//    
//    return self._context;
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
     [FBSDKLoginButton class];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    // Optional: set debug to YES for extra debugging information.
    //[GAI sharedInstance].debug = YES;
    // Create tracker instance.
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-36608494-1"];
    

#ifdef TESTING
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];

    
    [TestFlight takeOff:@"8d2caf14-8df9-4937-a9d7-3e91b0a5465b"];
#endif    
    //
    NSUserDefaults *userD = [[NSUserDefaults alloc] init];
    if (![userD objectForKey:@"quality"]) {
        [userD setObject:@"Medium" forKey:@"quality"];
        [userD synchronize];
    }
   
    
    _vc = [[MainViewController alloc] init];
    UINavigationController *tabBarController = [[UINavigationController alloc] init];
//    tabBarController.viewControllers = @[
//        [[UINavigationController alloc] initWithRootViewController:vc],
//    ];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    [tabBarController pushViewController:_vc animated:true];
    
   // [Parse enableLocalDatastore];
    //channel 66
   // [Parse setApplicationId:@"dmSTSXcOcBxITZBioUAmC7HXps0OCUteMJEklSCD" clientKey:@"b0gN0SoJgOmQ51fkQoNb9B7bNEIF2agc9SYhFG7U"];
    // test channle 66
    //[Parse setApplicationId:@"KZGRjYuBEwh6vubjJBRzscvVixyLC8fWg9YqAwVS" clientKey:@"H3JqHHIKrd8xN44weGfAsWmUeCJQdqh8bPR8H4M6"];
    //testchannel2
    
//    [Parse setApplicationId:@"ayoTJHpHAVbwWEprqxzQeYpYCIaxz98HY19DbQiF" clientKey:@"imLHqDJYiH6S3iPtZ3gw1yilsXna8wHM0oSiGktp"];
    
    [FIROptions defaultOptions].deepLinkURLScheme = @"fjca5.app.goo.gl";
      [FIRApp configure];
    
//    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
//    {
//        // iOS 8 Notifications
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        
//        [application registerForRemoteNotifications];
//    }
//    else
//    {
//        // iOS < 8 Notifications
//        [application registerForRemoteNotificationTypes:
//         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
//    }
//    
//    if (!launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
//        
//    }
    
   
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
//        UIUserNotificationType allNotificationTypes =
//        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
//        UIUserNotificationSettings *settings =
//        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//    } else {
//        // iOS 10 or later
//#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//        UNAuthorizationOptions authOptions =
//        UNAuthorizationOptionAlert
//        | UNAuthorizationOptionSound
//        | UNAuthorizationOptionBadge;
//        [[UNUserNotificationCenter currentNotificationCenter]
//         requestAuthorizationWithOptions:authOptions
//         completionHandler:^(BOOL granted, NSError * _Nullable error) {
//         }
//         ];
//
//        // For iOS 10 display notification (sent via APNS)
//        [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
//        // For iOS 10 data message (sent via FCM)
//       // [[FIRMessaging messaging] setRemoteMessageDelegate:self];
//#endif
//    }
//
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//
    
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:@"cc74f8f1-4494-4474-993c-dec8e27c60ee"
     
          handleNotificationReceived:^(OSNotification *notification) {
              NSLog(@"Recieved Push Notification");
              // [PFPush handlePush:userInfo];
              
              OSNotificationPayload* payload = notification.payload;
              
              NSManagedObjectContext *context = [DataStore  getInstance].managedObjectContext;
              //            var context2 = PortDelegate.persistentContainer;
              //
                          // Create a new managed object
                          NSManagedObject *messages = [NSEntityDescription insertNewObjectForEntityForName:@"Messages" inManagedObjectContext:context];
                          [messages setValue:[payload body] forKey:@"text"];
                          NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
              
                          [messages setValue:[NSDate date] forKey:@"date"];
                          [messages willSave];
              
                          NSError *error = nil;
                          // Save the object to persistent store
                          if (![context save:&error]) {
                              NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                          }
              
                  //        PFObject *messagesObject = [PFObject objectWithClassName:@"messages"];
                  //        messagesObject[@"text"] = [apsInfo objectForKey:@"alert"];
                  //        messagesObject[@"date"] = [NSDate date];
                  //        [messagesObject pinInBackground];
//                  NSManagedObjectContext *context = [DataStore getInstance].managedObjectContext;
//
//                  // Create a new managed object
//                  NSManagedObject *messages = [NSEntityDescription insertNewObjectForEntityForName:@"Messages" inManagedObjectContext:context];
//                  [messages setValue:[payload body] forKey:@"text"];
//              NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//              [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            
//                  [messages setValue:[NSDate date] forKey:@"date"];
//                  [messages willSave];
//
//                  NSError *error = nil;
//                  // Save the object to persistent store
//                  if (![context save:&error]) {
//                      NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//                  }


//                  NSString *text = notification.payload.body;
//                  NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
//                  NSArray* matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
//                  if([matches count] > 0)
//                  {
//                      NSURL *url  = [[matches objectAtIndex:0] URL];
//                      [[UIApplication sharedApplication] openURL:url];
//                  }
//                  else
//                  {
//                      BBmessagesTableViewController *bbm = [[BBmessagesTableViewController alloc]init];
//                      UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
//                      [navController pushViewController:bbm animated:true];
//                  }
             
             
          }
            handleNotificationAction:^(OSNotificationOpenedResult *result){
                
                // get the current date and time
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd\'T\'HH:mm:ssZZZZZ"];
                
                
                NSString *now = [dateFormat stringFromDate:[NSDate date]];
               
                
                // get the date time String from the date object
               
                
                [OneSignal sendTag:now value:@"opened"];
                
            }
                            settings:@{kOSSettingsKeyAutoPrompt: @false}];
    OneSignal.inFocusDisplayType = OSNotificationDisplayTypeNotification;
   
    
    
    
    UNNotificationAction* confirm = [UNNotificationAction  actionWithIdentifier:@"OK" title:@"OK" options:UNNotificationActionOptionForeground];
    
    
    UNNotificationCategory * notifCategory =  [UNNotificationCategory categoryWithIdentifier:@"Confirm" actions:[NSArray arrayWithObject:confirm] intentIdentifiers:[NSArray array] options:[NSArray array]];
    
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:notifCategory]];
    
    
    
    //   how your app will use them.
    [OneSignal promptForPushNotificationsWithUserResponse:^(BOOL accepted) {
        NSLog(@"User accepted notifications: %d", accepted);
    }];
    
   
    // Override point for customization after application launch.
    
    
    
    
    
    //Enabling keyboard manager
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:15];
    
    //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create IQToolbar for keyboard.
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    
    
    //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField’s tag property in increasing order.
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    
    
    //Resign textField if touched outside of UITextField/UITextView.
    
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    
    
    //Giving permission to modify TextView’s frame
    
//    [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
//
//
//
//    //Show TextField placeholder texts on autoToolbar
//
//    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
//
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"Registered"])
    {
        RegisterViewController *bbm = [[RegisterViewController alloc]init];
        UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
        [navController  presentModalViewController:bbm animated:YES];
    }
    else
    {
        [OneSignal setSubscription:false];
    }
    

    
    
    
    
    
        return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    NSLog(@"Didregisterfornotifications");
    // Store the deviceToken in the current installation and save it to Parse.
  //  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    //[currentInstallation addUniqueObject:@"RABASH" forKey:@"channels"];
  //  [currentInstallation setDeviceTokenFromData:newDeviceToken];
   // [currentInstallation saveInBackground];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"failed");
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
    return [self application:app openURL:url sourceApplication:nil annotation:@{}];
}

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    FIRDynamicLink *dynamicLink =
//    [[FIRDynamicLinks dynamicLinks] dynamicLinkFromCustomSchemeURL:url];
//    
//    if (dynamicLink) {
//        // Handle the deep link. For example, show the deep-linked content or
//        // apply a promotional offer to the user's account.
//        // ...
//        return YES;
//    }
//    
//    return NO;
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSArray* allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"kabbalahgroup.info"]];
    for (NSHTTPCookie *cookie in allCookies) {
        if ([cookie.name isEqualToString:@""]) {
            NSMutableDictionary* cookieDictionary = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"kabbala"]];
            [cookieDictionary setValue:cookie.properties forKey:@"kabbalahgroup.info"];
            [[NSUserDefaults standardUserDefaults] setObject:cookieDictionary forKey:@"cookie"];
        }
    }

}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Recieved Psuh Notification");
   // [PFPush handlePush:userInfo];
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    if( [apsInfo objectForKey:@"alert"] != NULL)
    {
//        PFObject *messagesObject = [PFObject objectWithClassName:@"messages"];
//        messagesObject[@"text"] = [apsInfo objectForKey:@"alert"];
//        messagesObject[@"date"] = [NSDate date];
//        [messagesObject pinInBackground];
        NSManagedObjectContext *context = [DataStore getInstance].managedObjectContext;
        
        // Create a new managed object
        NSManagedObject *messages = [NSEntityDescription insertNewObjectForEntityForName:@"Messages" inManagedObjectContext:context];
        [messages setValue:[apsInfo objectForKey:@"alert"] forKey:@"text"];
        [messages setValue:[NSDate date] forKey:@"date"];
        [messages willSave];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        NSString *text = [apsInfo objectForKey:@"alert"];
        NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray* matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
        if([matches count] > 0)
        {
            NSURL *url  = [[matches objectAtIndex:0] URL];
            [[UIApplication sharedApplication] openURL:url];
        }
        else
        {
            BBmessagesTableViewController *bbm = [[BBmessagesTableViewController alloc]init];
            UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
            [navController pushViewController:bbm animated:true];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"applicationDidEnterBackground");
    
    //id audioManager = [KxAudioManager audioManager];
    //[audioManager deactivateAudioSession];
    
    
    
    __block UIBackgroundTaskIdentifier task = 0;
    task=[application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Expiration handler called %f",[application backgroundTimeRemaining]);
        [application endBackgroundTask:task];
        task=UIBackgroundTaskInvalid;
    }];
}

- (BOOL)application:(UIApplication *)application
continueUserActivity:(NSUserActivity *)userActivity
 restorationHandler:(void (^)(NSArray *))restorationHandler {
    
    BOOL handled = [[FIRDynamicLinks dynamicLinks]
                    handleUniversalLink:userActivity.webpageURL
                    completion:^(FIRDynamicLink * _Nullable dynamicLink,
                                 NSError * _Nullable error) {
                        // ...
                        if([[[dynamicLink url ] absoluteString] isEqualToString:@"https://channel66.com/radio"])
                        {
                            NSLog(@"Got a link");
                            //play radio
                            [((MainViewController*)_vc) startRadio];
                        }
                    }];
    
    
    return handled;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSDictionary* cookieDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"cookie"];
    NSDictionary* cookieProperties = [cookieDictionary valueForKey:@"kabbala"];
    if (cookieProperties != nil) {
        NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        NSArray* cookieArray = [NSArray arrayWithObject:cookie];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookieArray forURL:[NSURL URLWithString:@"kabbalahgroup.info"] mainDocumentURL:nil];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
   // [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:url mainDocumentURL:nil]; // where cookies is the unarchived array of cookies
  
  }

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    FIRDynamicLink *dynamicLink =
    [[FIRDynamicLinks dynamicLinks] dynamicLinkFromCustomSchemeURL:url];
    
    if (dynamicLink) {
        // Handle the deep link. For example, show the deep-linked content or
        // apply a promotional offer to the user's account.
        // ...
        return YES;
    }

    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"channel66"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)setupManagedObjectContext
{
    NSURL *nsurl =[[NSBundle mainBundle] URLForResource:@"Message" withExtension:@"momd"];
    
    NSManagedObjectModel * managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:nsurl];
    self.managedObjectContext =
    [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSError* error;
    [self.managedObjectContext.persistentStoreCoordinator
     addPersistentStoreWithType:NSSQLiteStoreType
     configuration:nil
     URL:[self storeURL]
     options:nil
     error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
}
- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

@end
