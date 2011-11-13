//
//  FileViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSFile.h"
@interface FileViewController : UIViewController <SSFileDelegate>;
@property (strong) SSFile* file;
- (id)initWithFile:(SSFile*) file;

@end
