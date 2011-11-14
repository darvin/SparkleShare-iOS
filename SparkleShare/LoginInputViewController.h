//
//  LoginInputViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginInputViewController;
@protocol LoginInputViewControllerDelegate <NSObject>

- (void)loginInputViewController: (LoginInputViewController *)loginInputViewController
       willSetLink: (NSURL *)link code: (NSString *)code;

@end


@interface LoginInputViewController : UIViewController
@property (strong, nonatomic) id <LoginInputViewControllerDelegate> delegate;
@end