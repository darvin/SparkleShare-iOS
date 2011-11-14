//
//  ManualLoginInputViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginInputViewController.h"

@interface ManualLoginInputViewController : LoginInputViewController
@property (retain) IBOutlet UITextField *urlField;
@property (retain) IBOutlet UITextField *codeField;

@end