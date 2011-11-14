//
//  SparkleShareAppDelegate.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SparkleShareAppDelegate.h"
#import "SelectLoginInputViewController.h"
#import "FolderViewController.h"

#import "StartingViewController.h"

@implementation SparkleShareAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
//@synthesize splitViewController = _splitViewController;

- (BOOL)application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
	self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];

	connection = [[SSConnection alloc] initWithUserDefaults];
	connection.delegate = self;

	StartingViewController *startingViewController = [[StartingViewController alloc] init];
	self.window.rootViewController = startingViewController;


	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive: (UIApplication *) application {
	/*
	   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground: (UIApplication *) application {
	/*
	   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground: (UIApplication *) application {
	/*
	   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive: (UIApplication *) application {
	/*
	   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate: (UIApplication *) application {
	/*
	   Called when the application is about to terminate.
	   Save data if appropriate.
	   See also applicationDidEnterBackground:.
	 */
}

- (void)loginInputViewController: (LoginInputViewController *) loginInputViewController
       willSetLink: (NSURL *) link code: (NSString *) code;
{
	[connection linkDeviceWithAddress: link code: code];
}


- (void) connectionEstablishingSuccess: (SSConnection *) aConnection {
	//fixme ugly casting
	id rootFolder = aConnection.rootFolder;
	NSAssert([rootFolder isKindOfClass: [SSFolder class]], @"Return value is not of type SSFolder as expected.");
	FolderViewController *folderViewController = [[FolderViewController alloc] initWithFolder: rootFolder];
	self.navigationController = [[UINavigationController alloc] initWithRootViewController: folderViewController];
	self.window.rootViewController = self.navigationController;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        SparkleShareMasterViewController *masterViewController = [[SparkleShareMasterViewController alloc] initWithConnection:aConnection];
//        self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
//        self.window.rootViewController = self.navigationController;
//    } else {
//        SparkleShareMasterViewController *masterViewController = [[SparkleShareMasterViewController alloc] initWithConnection:aConnection];
//        UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
//
//        SparkleShareDetailViewController *detailViewController = [[SparkleShareDetailViewController alloc] initWithNibName:@"SparkleShareDetailViewController_iPad" bundle:nil];
//        UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
//
//        self.splitViewController = [[UISplitViewController alloc] init];
//        self.splitViewController.delegate = detailViewController;
//        self.splitViewController.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController, nil];
//
//        self.window.rootViewController = self.splitViewController;
//    }
}

- (void) connectionEstablishingFailed: (SSConnection *) connection {
	//todo: eliminate reinitialization
	SelectLoginInputViewController *selectLoginInputViewController = [[SelectLoginInputViewController alloc] initWithNibName: @"SelectLoginInputViewController" bundle: nil];
	selectLoginInputViewController.delegate = self;
	self.navigationController = [[UINavigationController alloc] initWithRootViewController: selectLoginInputViewController];
	self.window.rootViewController = self.navigationController;
}

@end