//
//  FolderViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSFolder.h"

@interface FolderViewController : UITableViewController <SSFolderInfoDelegate, SSFolderItemsDelegate>

@property (strong) SSFolder* folder;
- (id)initWithFolder:(SSFolder*) folder;


-(void) folder:(SSFolder*) folder itemsLoaded:(NSArray*) items;
-(void) folderLoadingFailed:(SSFolder*) folder;
-(void) folder:(SSFolder*) folder countLoaded:(int) count;

-(void) folder:(SSFolder*) folder revisionLoaded:(NSString*) revision;
-(void) folder:(SSFolder*) folder overallCountLoaded:(int) count;
-(void) folderInfoLoadingFailed:(SSFolder*) folder;

@end
