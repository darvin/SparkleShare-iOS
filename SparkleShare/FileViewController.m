//
//  FileViewController.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FileViewController.h"

@implementation FileViewController
@synthesize file = _file;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.file loadContent];
}

#pragma mark - SSFile stuff
- (id)initWithFile:(SSFile *)file
{
    if (self = [super init]) {
        self.file = file;
        self.file.delegate = self;
        self.title = self.file.name;

    }
    return self;
}

-(void) file:(SSFile*) file contentLoaded:(NSData*) content
{
    NSLog(@"fileloaded");
}

-(void) fileContentLoadingFailed:(SSFile*) file
{
    NSLog(@"fileloading failed");
}

@end
