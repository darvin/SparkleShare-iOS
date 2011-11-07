//
//  SSConnection.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSConnection.h"

@interface SSConnection ()
-(void) linkDevice;
@end

@implementation SSConnection
@synthesize identCode, authCode, address;

-(id) initWithAddress:(NSString*)anAddress code:(NSString*)aCode
{
    if (self=[self init]){
        address = anAddress;
        code = aCode;
    }
    return self;
}

-(id) initWithAddress:(NSString*)anAddress identCode:(NSString*)anIdentCode authCode:(NSString*)anAuthCode
{
    if ([self init]){
        authCode = anAuthCode;
        identCode = anIdentCode;
    }
    return self;
}


//$ curl --data "code=286685&name=My%20Name" http://localhost:3000/api/getAuthCode
//{"ident":"qj7cGswA","authCode":"iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-"}
-(void) linkDevice
{
    if (!identCode||!authCode) {
        //fixme post data
        identCode = @"";
        authCode = @"";
    }
    
}

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getFolderList
//[{"name":"Git1","id":"c0acdbe1e1fec3290db71beecc9af500af126f8d","type":"git"}]
-(NSArray*) folders
{
    if (!folders) {
        ;//fill folders
    }
    return folders;
}

//returns data from url {self->
-(NSData*) getDataWithRequest:(NSString*)request
{
    [self linkDevice];
}

-(id*) getObjectWithRequest:(NSString*)request
{
    [self linkDevice];

}


@end
