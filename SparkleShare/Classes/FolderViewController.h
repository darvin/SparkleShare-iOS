//
//  FolderViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSFolder.h"
#import "SSFile.h"
#import "PullToRefreshTableViewController.h"

@interface FolderViewController : PullToRefreshTableViewController <SSFolderInfoDelegate, SSFolderItemsDelegate, SSFileDelegate>

@property (strong) SSFolder *folder;
- (id)initWithFolder: (SSFolder *) folder;

@property int iconSize;
@end