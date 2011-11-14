//
//  FileViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import "FilePreview.h"
@interface FileViewController : QLPreviewController <QLPreviewControllerDataSource>;
@property (strong) FilePreview *filePreview;
- (id)initWithFilePreview: (FilePreview *)filePreview filename: (NSString *)filename;

@end