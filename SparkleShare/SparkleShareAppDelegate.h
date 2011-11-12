//
//  SparkleShareAppDelegate.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginInputViewController.h"
#import "SSConnection.h"
@interface SparkleShareAppDelegate : UIResponder <UIApplicationDelegate, LoginInputViewControllerDelegate, SSConnectionDelegate>
{
    SSConnection* connection;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
