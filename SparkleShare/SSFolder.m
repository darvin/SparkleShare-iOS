//
//  SSFolder.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFolder.h"

@implementation SSFolder
@synthesize name, ssid, type;


-(id) initWithConnection:(SSConnection*)aConnection
                    name:(NSString*)aName 
                    ssid:(NSString*)anId
                    type:(NSString*)aType
{
    if ([self init]){
        connection = aConnection;
        name = aName;
        ssid = anId;
        type = aType;
    }
    return self;
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getAllItemCount/c0acdbe1e1fec3290db71beecc9af500af126f8d
//14
-(int) count
{
    if (!count){
        //perform
    }
    return count;
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getFolderRevision/c0acdbe1e1fec3290db71beecc9af500af126f8d
//"b26aa22664f2b9759d93df228e1a8c4693dc44af"
-(NSString*) revision
{
    if (!revision){
        //perform
    }
    return revision;
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getFolderContent/c0acdbe1e1fec3290db71beecc9af500af126f8d
//[{"id":"83d20198fb3aa38143294226785893964d44b896","type":"file","name":"b","url":"path=b&hash=83d20198fb3aa38143294226785893964d44b896&name=b"},
//{"id":"b59993a22c86c5e84973d907bce7a4baf04bdb28","type":"dir","name":"c","url":"path=c&hash=b59993a22c86c5e84973d907bce7a4baf04bdb28&name=c"}]
-(NSArray*) items
{
    if (!items){
        //perform
    }
    return items;
}

//returns data from url http://localhost:3000/api/{method}/{self->ssid}?{path}
-(NSData*) getDataWithMethod:(NSString*)method path:(NSString*)path
{
    
}

//returns decoded data from url http://localhost:3000/api/{method}/{self->ssid}?{path}
-(id*) getObjectWithMethod:(NSString*)method path:(NSString*)path
{
    
}

@end
