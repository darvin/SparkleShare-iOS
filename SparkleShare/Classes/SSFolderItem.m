//
//  SSFolderItem.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFolderItem.h"
#import "SSConnection.h"
#import "SSFolder.h"

@implementation SSFolderItem
@synthesize name = _name, ssid = _ssid, url = _url, projectFolder = _projectFolder, mime=_mime;


- (id) initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId;
{
	if (self = [super init]) {
		connection = aConnection;
		self.name = aName;
		self.ssid = anId;
	}
	return self;
}


- (id) initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId
       url: (NSString *) anUrl
       projectFolder: (SSFolder *) projectFolder {
	if (self = [self initWithConnection: aConnection name: aName ssid: anId]) {
		self.url = anUrl;
		self.projectFolder = projectFolder;
	}
	return self;
}

- (void) sendRequestWithSelfUrlAndMethod: (NSString *) method
       success: ( void (^)(NSURLRequest * request, NSURLResponse * response, id JSON) ) success
       failure: ( void (^)(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) ) failure {
	if (self.url) {
		[self.projectFolder sendRequestWithMethod: method path: self.url success: success failure: failure];
	}
	else {
		[self.projectFolder sendRequestWithMethod: method success: success failure: failure];
	}
}

//http://localhost:3000/api/{method}/{self->ssid}
- (void) sendRequestWithMethod: (NSString *) method
       success: ( void (^)(NSURLRequest * request, NSURLResponse * response, id JSON) ) success
       failure: ( void (^)(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) ) failure {
	[connection sendRequestWithString: [NSString stringWithFormat: @"/api/%@/%@", method, self.ssid] success: success failure: failure];
}

//http://localhost:3000/api/{method}/{self->ssid}?{path}
- (void) sendRequestWithMethod: (NSString *) method path: (NSString *) path
       success: ( void (^)(NSURLRequest * request, NSURLResponse * response, id JSON) ) success
       failure: ( void (^)(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) ) failure {
	[connection sendRequestWithString: [NSString stringWithFormat: @"/api/%@/%@?%@", method, self.ssid, path] success: success failure: failure];
}

@end