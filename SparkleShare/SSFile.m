//
//  SSFile.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFile.h"
#import "TTTURLRequestFormatter.h"

@implementation SSFile
@synthesize delegate = _delegate;
@synthesize content = _content;
@synthesize filesize = _filesize, mime = _mime;


- (id) initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId
       url: (NSString *) anUrl
       projectFolder: (SSFolder *) projectFolder
       mime: (NSString *) mime
       filesize: (int) filesize;
{
	if (self = [super initWithConnection: aConnection name: aName ssid: anId url: anUrl projectFolder: projectFolder]) {
		self.mime = mime;
		self.filesize = filesize;
	}
	return self;
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
// //-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
// //"http://localhost:3000/api/getFile/c0acdbe1e1fec3290db71beecc9\
// //af500af126f8d?path=c%2Fd&hash=21efaca824f4705deeb9ef6025fd879c871a7117&name=d"
//(BINARY DATA)
- (void) loadContent {
	[self sendRequestWithSelfUrlAndMethod: @"getFile" success:
	 ^(NSURLRequest * request, NSURLResponse * response, id JSON) {
	         NSData *content = JSON;
	         self.content = content;
	         [self.delegate file: self contentLoaded: self.content];
	 }
	 failure:
	 ^(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) {
	         [self.delegate fileContentLoadingFailed: self];
	 }
	];
}

@end