//
//  SSFolderItem.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSConnection;
@class SSFolder;

@interface SSItem : NSObject
{
	SSConnection *connection;
}

- (id)initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId
       url: (NSString *) anUrl
       projectFolder: (SSFolder *) projectFolder;

- (id)initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId;

@property (copy) NSString *name;
@property (copy) NSString *ssid;
@property (copy) NSString *url;
@property (weak) SSFolder *projectFolder;

- (void)sendRequestWithSelfUrlAndMethod: (NSString *) method
       success: ( void (^)(NSURLRequest * request, NSURLResponse * response, id JSON) ) success
       failure: ( void (^)(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) ) failure;
//http://localhost:3000/api/{method}/{self->ssid}
- (void)sendRequestWithMethod: (NSString *) method
       success: ( void (^)(NSURLRequest * request, NSURLResponse * response, id JSON) ) success
       failure: ( void (^)(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) ) failure;
//http://localhost:3000/api/{method}/{self->ssid}?{path}
- (void)sendRequestWithMethod: (NSString *) method path: (NSString *) path
       success: ( void (^)(NSURLRequest * request, NSURLResponse * response, id JSON) ) success
       failure: ( void (^)(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) ) failure;


@end