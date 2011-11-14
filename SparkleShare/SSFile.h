//
//  SSFile.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSItem.h"

@class SSFile;
@protocol SSFileDelegate <NSObject>
- (void)file: (SSFile *) file contentLoaded: (NSData *) content;
- (void)fileContentLoadingFailed: (SSFile *) file;
@end


@interface SSFile : SSItem

- (id)initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId
       url: (NSString *) anUrl
       projectFolder: (SSFolder *) projectFolder
       mime: (NSString *) mime
       filesize: (int) filesize;


@property (strong) NSData *content;
@property (copy) NSString *mime;
@property int filesize;
@property (weak) id <SSFileDelegate> delegate;
- (void)loadContent;
@end