//
//  SelectLoginInputViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginInputViewController.h"

@interface SelectLoginInputViewController : LoginInputViewController <LoginInputViewControllerDelegate>
- (void)loginInputViewController: (LoginInputViewController *)loginInputViewController
       willSetLink: (NSURL *)link code: (NSString *)code;

- (IBAction)openQRCodeView: (id)sender;
- (IBAction)openManualView: (id)sender;

@end