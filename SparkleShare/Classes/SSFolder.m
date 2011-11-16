//
//  SSFolder.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFolder.h"
#import "SSFile.h"
#import "SSConnection.h"
#import "TTTURLRequestFormatter.h"

@interface SSFolder ()
@end

@implementation SSFolder
@synthesize name = _name, ssid = _ssid, type = _type;
@synthesize count = _count, revision = _revision, items = _items, overallCount = _overallCount;
@synthesize delegate = _delegate;
@synthesize infoDelegate = _infoDelegate;

- (id) initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId
       type: (NSString *) aType {
	if (self = [self initWithConnection: aConnection name: aName ssid: anId]) {
		self.type = aType;
	}
	return self;
}


- (NSString*) mime {
    return @"text/directory";
}

- (id) initWithConnection: (SSConnection *) aConnection
       name: (NSString *) aName
       ssid: (NSString *) anId;
{
	if (self = [super initWithConnection: aConnection name: aName ssid: anId]) {
		self.projectFolder = self;
	}
	return self;
}


//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
// //-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
// //http://localhost:3000/api/getAllItemCount/c0acdbe1e1fec3290db71beecc9af500af126f8d
//14
- (void) loadOverAllCount {
	[self sendRequestWithMethod: @"getAllItemCount" success:
	 ^(NSURLRequest * request, NSURLResponse * response, id JSON) {
	         NSNumber *count = JSON;
	         self.overallCount = [count intValue]; //fixme
	         [self.infoDelegate folder: self overallCountLoaded: self.overallCount];
	 }
	 failure:
	 ^(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) {
	         [self.infoDelegate folderInfoLoadingFailed: self];
	 }
	];
}


- (void) loadCount {
	[self sendRequestWithSelfUrlAndMethod: @"getFolderItemCount" success:
	 ^(NSURLRequest * request, NSURLResponse * response, id JSON) {
	         NSNumber *count = JSON;
	         self.count = [count intValue]; //fixme
	         [self.infoDelegate folder: self countLoaded: self.count];
	 }
	 failure:
	 ^(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) {
	         [self.infoDelegate folderInfoLoadingFailed: self];
	 }
	];
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
// //-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
// //http://localhost:3000/api/getFolderRevision/c0acdbe1e1fec3290db71beecc9af500af126f8d
//"b26aa22664f2b9759d93df228e1a8c4693dc44af"
- (void) loadRevision {
	[self sendRequestWithMethod: @"getFolderRevision" success:
	 ^(NSURLRequest * request, NSURLResponse * response, id JSON) {
	         self.revision = JSON;
	         [self.infoDelegate folder: self revisionLoaded: self.revision];
	 }
	 failure:
	 ^(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) {
	         [self.infoDelegate folderInfoLoadingFailed: self];
	 }
	];
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
// //-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
// //http://localhost:3000/api/getFolderContent/c0acdbe1e1fec3290db71beecc9af500af126f8d
//[{"id":"83d20198fb3aa38143294226785893964d44b896","type":"file","name":"b","url":"path=b&hash=83d20198fb3aa38143294226785893964d44b896&name=b"},
//{"id":"b59993a22c86c5e84973d907bce7a4baf04bdb28","type":"dir","name":"c","url":"path=c&hash=b59993a22c86c5e84973d907bce7a4baf04bdb28&name=c"}]
- (void) loadItems {
	[self sendRequestWithSelfUrlAndMethod: @"getFolderContent" success:
	 ^(NSURLRequest * request, NSURLResponse * response, id JSON) {
	         NSMutableArray *newItems = [NSMutableArray array];
	         for (NSDictionary * itemInfo in JSON) {
	                 NSString *type = [itemInfo objectForKey: @"type"];
	                 SSFolderItem *newItem;
	                 if ([type isEqual: @"file"]) {
	                         newItem = [[SSFile alloc] initWithConnection: connection name: [itemInfo objectForKey: @"name"] ssid: [itemInfo objectForKey: @"id"] url: [itemInfo objectForKey: @"url"] projectFolder: self.projectFolder mime: [itemInfo objectForKey: @"mime"] filesize: [[itemInfo objectForKey: @"fileSize"] intValue]];
			 }
	                 else if ([type isEqual: @"dir"]) {
	                         newItem = [[SSFolder alloc] initWithConnection: connection name: [itemInfo objectForKey: @"name"] ssid: [itemInfo objectForKey: @"id"] url: [itemInfo objectForKey: @"url"] projectFolder: self.projectFolder];
			 }


	                 [newItems addObject: newItem];
		 }
	         [self loadedItems: [NSArray arrayWithArray: newItems]];
	 }
	 failure:
	 ^(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) {
	         [self.delegate folderLoadingFailed: self];
	 }
	];
}

- (void) loadedItems: (NSArray *) items {
	self.items = items;
	[self.delegate folder: self itemsLoaded: self.items];
}

@end