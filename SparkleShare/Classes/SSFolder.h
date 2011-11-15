//
//  SSFolder.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSFolderItem.h"

@class SSFolder;
@class SSConnection;


@protocol SSFolderItemsDelegate <NSObject>
- (void)folder: (SSFolder *) folder itemsLoaded: (NSArray *) items;
- (void)folderLoadingFailed: (SSFolder *) folder;
@end


@protocol SSFolderInfoDelegate <NSObject>
- (void)folder: (SSFolder *) folder revisionLoaded: (NSString *) revision;
- (void)folder: (SSFolder *) folder overallCountLoaded: (int) count;
- (void)folderInfoLoadingFailed: (SSFolder *) folder;
- (void)folder: (SSFolder *) folder countLoaded: (int) count;
@end



@interface SSFolder : SSFolderItem
{
}
- (id)initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId
       type: (NSString *) aType;


- (void)loadRevision;
- (void)loadItems;
- (void)loadCount;

@property (copy) NSString *type;

@property int count;
@property int overallCount;
@property (copy) NSString *revision;
@property (copy) NSArray *items;
@property (weak) id <SSFolderInfoDelegate> infoDelegate;
@property (weak) id <SSFolderItemsDelegate> delegate;

- (void)loadedItems: (NSArray *) items;

@end