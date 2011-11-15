//
//  LoginInputViewController.m
//  SparkleShare
//
//  Created by Sergey Klimov on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginInputViewController.h"
#import "UIViewController+AutoPlatformNibName.h"
@implementation LoginInputViewController
@synthesize delegate = _delegate;

- (id) init {
    return [self initWithAutoPlatformNibName];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(editDone:)];
}

- (void) editDone: (id) sender {
	[NSException raise: NSInternalInconsistencyException
	 format: @"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end