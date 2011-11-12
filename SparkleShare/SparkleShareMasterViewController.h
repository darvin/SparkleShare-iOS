//
//  SparkleShareMasterViewController.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSConnection.h"

@class SparkleShareDetailViewController;
@class SSConnection;

@interface SparkleShareMasterViewController : UITableViewController <SSConnectionFoldersDelegate>

{
}

@property (strong, nonatomic) SparkleShareDetailViewController *detailViewController;
@property (strong) SSConnection* connection;
- (id)initWithConnection:(SSConnection*) aConnection;
-(void) connection:(SSConnection*) connection foldersLoaded:(NSArray*) folders;
-(void) connectionFoldersLoadingFailed:(SSConnection*) connection;
@end
