//
//  SSRootFolder.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSRootFolder.h"
#import "SSConnection.h"
@implementation SSRootFolder

-(id) initWithConnection:(SSConnection *)aConnection
{
    if (self=[super init]){
        connection = aConnection;
        self.name = @"_ROOT_";
    }
    return self;
}
//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getFolderList
//[{"name":"Git1","id":"c0acdbe1e1fec3290db71beecc9af500af126f8d","type":"git"}]


-(void) loadItems
{
    [connection sendRequestWithString:@"/api/getFolderList" 
                        success:
     ^(NSURLRequest *request, NSURLResponse *response, id JSON) {
         NSLog(@"%@ %@", response, JSON);
         NSMutableArray* newFolders = [NSMutableArray array]; 
         for (NSDictionary* folderInfo in JSON) {
             SSFolder* newFolder = [[SSFolder alloc] initWithConnection:connection
                                                                   name:[folderInfo objectForKey:@"name"]
                                                                   ssid:[folderInfo objectForKey:@"id"]
                                                                   type:[folderInfo objectForKey:@"type"]];
             [newFolders addObject:newFolder];
         }
         [self loadedItems:[NSArray arrayWithArray:newFolders]];
     } 
                        failure:
     ^( NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON ){
         NSLog(@"%@ %@", response, error);
         
         [self.delegate folderLoadingFailed:self];
     } ];
}
@end
