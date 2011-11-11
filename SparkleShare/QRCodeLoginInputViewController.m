//
//  QRCodeLoginInputViewController.m
//  SparkleShare
//
//  Created by Sergey Klimov on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QRCodeLoginInputViewController.h"
#import "ZBarSDK.h"
@interface QRCodeLoginInputViewController()
@end


@implementation QRCodeLoginInputViewController
@synthesize readerView, urlLabel, codeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [ZBarReaderView class];
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
    // the delegate receives decode results
    readerView.readerDelegate = self;
    qrCaptured = NO;
    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    [readerView start];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [readerView stop];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    NSString* result;
    NSString* prefix = @"SSHARE:";
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        result = sym.data;
        break;
    }
    
    if ([result hasPrefix:prefix]){
        NSArray *chunks = [[result substringFromIndex:[prefix length]] componentsSeparatedByString: @"#"];
        if ([chunks count]==2){
            self.urlLabel.text = [chunks objectAtIndex:0];
            self.codeLabel.text = [chunks objectAtIndex:1];
            qrCaptured = YES;
        }
    }
    
}

-(void) editDone:(id) sender
{
    if (qrCaptured)
        [self.delegate loginInputViewController:self willSetLink:[NSURL URLWithString:self.urlLabel.text ] code:self.codeLabel.text];
    else
        [self.navigationController popViewControllerAnimated:YES];
    
}


@end
