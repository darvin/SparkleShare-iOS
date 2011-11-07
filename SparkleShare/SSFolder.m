//
//  SSFolder.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFolder.h"

@interface SSFolder () 
-(NSData*) getDataWithMethod:(NSString*)method;
-(id*) getObjectWithMethod:(NSString*)method;
@end

@implementation SSFolder
@synthesize name, ssid, type;


-(id) initWithConnection:(SSConnection*)aConnection
                    name:(NSString*)aName 
                    ssid:(NSString*)anId
                    type:(NSString*)aType
{
    self=[self init];
    connection = aConnection;
    name = aName;
    ssid = anId;
    type = aType;
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
        [self getDataWithMethod:@"getAllItemCount"];

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
        [self getDataWithMethod:@"getFolderRevision"];

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
        [self getDataWithMethod:@"getFolderContent"];
    }
    return items;
}

//returns data from url http://localhost:3000/api/{method}/{self->ssid}?{path}
-(NSData*) getDataWithMethod:(NSString*)method path:(NSString*)path
{
    return [connection getDataWithRequest:[NSString stringWithFormat:@"%@/%@?%@", method, ssid, path]];
}

//returns decoded data from url http://localhost:3000/api/{method}/{self->ssid}?{path}
-(id*) getObjectWithMethod:(NSString*)method path:(NSString*)path
{
    return [connection getObjectWithRequest:[NSString stringWithFormat:@"%@/%@?%@", method, ssid, path]];
}


//returns data from url http://localhost:3000/api/{method}/{self->ssid}
-(NSData*) getDataWithMethod:(NSString*)method
{
    return [connection getDataWithRequest:[NSString stringWithFormat:@"%@/%@", method, ssid]];
}

//returns decoded data from url http://localhost:3000/api/{method}/{self->ssid}
-(id*) getObjectWithMethod:(NSString*)method
{
    return [connection getObjectWithRequest:[NSString stringWithFormat:@"%@/%@", method, ssid]];
}


@end
