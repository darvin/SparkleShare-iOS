//
//  QRCodeLoginInputViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginInputViewController.h"
#import "ZBarSDK.h"

@interface QRCodeLoginInputViewController : LoginInputViewController <ZBarReaderViewDelegate>
{
	ZBarReaderView *readerView;
	ZBarCameraSimulator *cameraSim;
	UILabel *codeLabel;
	UILabel *urlLabel;
	BOOL qrCaptured;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UILabel *codeLabel;
@property (nonatomic, retain) IBOutlet UILabel *urlLabel;



@end