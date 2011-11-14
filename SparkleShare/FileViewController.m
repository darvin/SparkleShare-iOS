//
//  FileViewController.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FileViewController.h"
#import "FilePreview.h"

@implementation FileViewController
@synthesize filePreview = _filePreview;



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

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
- (id)initWithFilePreview: (FilePreview *) filePreview filename: (NSString *) filename {
	if (self = [super init]) {
		self.filePreview = filePreview;
		self.dataSource = self;
		self.title = filename;
	}
	return self;
}

- (NSInteger)numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller {
	if (self.filePreview) {
		return 1;
	}
	else {
		return 0;
	}
}

- (id <QLPreviewItem>)previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index;
{
	if (index == 0 && self.filePreview) {
		return self.filePreview;
	}
	return nil;
};


@end