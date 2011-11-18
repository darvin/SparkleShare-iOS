//
//  StartingViewController.m
//  SparkleShare
//
//  Created by Sergey Klimov on 14.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StartingViewController.h"
#import "SVProgressHUD.h"
#import "UIViewController+AutoPlatformNibName.h"


@implementation StartingViewController

-(id) init {
    return [self initWithAutoPlatformNibName];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void) viewDidAppear: (BOOL) animated {
	[SVProgressHUD showWithStatus:@"Connecting"];
}

- (void) viewWillDisappear: (BOOL) animated {
	[SVProgressHUD dismiss];
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end