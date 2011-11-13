//
//  SSFolder.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFolder.h"
#import "SSConnection.h"
#import "TTTURLRequestFormatter.h"

@implementation SSFolder
@synthesize name=_name, ssid=_ssid, type=_type;
@synthesize count=_count, revision=_revision, items=_items;
@synthesize delegate=_delegate;
@synthesize infoDelegate=_infoDelegate;

-(id) initWithConnection:(SSConnection*)aConnection
                    name:(NSString*)aName 
                    ssid:(NSString*)anId
                    type:(NSString*)aType
{
    if (self=[self initWithConnection:aConnection name: aName ssid: anId]) {
        self.type = aType;
    }
    return self;
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getAllItemCount/c0acdbe1e1fec3290db71beecc9af500af126f8d
//14
-(void) loadCount
{
    [self sendRequestWithMethod:@"getAllItemCount" success:
     ^(NSURLRequest *request, NSURLResponse *response, id JSON) {
         NSNumber* count = JSON;
         self.count = [count intValue]; //fixme
         [self.infoDelegate folder:self countLoaded:self.count];
     } 
                        failure:
     ^( NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON ){
         [self.infoDelegate folderInfoLoadingFailed:self];
     }];
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getFolderRevision/c0acdbe1e1fec3290db71beecc9af500af126f8d
//"b26aa22664f2b9759d93df228e1a8c4693dc44af"
-(void) loadRevision
{    
    [self sendRequestWithMethod:@"getFolderRevision" success:
     ^(NSURLRequest *request, NSURLResponse *response, id JSON) {
         self.revision = JSON;
         [self.infoDelegate folder:self revisionLoaded:self.revision];
     } 
                        failure:
     ^( NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON ){
         [self.infoDelegate folderInfoLoadingFailed:self];
     }];
    
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getFolderContent/c0acdbe1e1fec3290db71beecc9af500af126f8d
//[{"id":"83d20198fb3aa38143294226785893964d44b896","type":"file","name":"b","url":"path=b&hash=83d20198fb3aa38143294226785893964d44b896&name=b"},
//{"id":"b59993a22c86c5e84973d907bce7a4baf04bdb28","type":"dir","name":"c","url":"path=c&hash=b59993a22c86c5e84973d907bce7a4baf04bdb28&name=c"}]
-(void) loadItems
{
    [self sendRequestWithMethod:@"getFolderContent" success:
     ^(NSURLRequest *request, NSURLResponse *response, id JSON) {
         NSLog(@"%@ %@", response, JSON);
         
         [self.delegate folder:self itemsLoaded:nil];
     } 
                        failure:
     ^( NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON ){
         NSLog(@"%@ %@", response, error);
         
         [self.delegate folderLoadingFailed:self];
     }];
}

@end
