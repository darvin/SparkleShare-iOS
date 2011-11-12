//
//  SSFolderItem.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSItem.h"
#import "SSConnection.h"

@implementation SSItem
@synthesize name=_name, ssid=_ssid, url=_url;


-(id) initWithConnection:(SSConnection*)aConnection
                    name:(NSString*)aName 
                    ssid:(NSString*)anId;
{
    if (self=[super init]){
        connection = aConnection;
        self.name = aName;
        self.ssid = anId;
    }
    return self;
}


-(id) initWithConnection:(SSConnection*)aConnection
                    name:(NSString*)aName 
                    ssid:(NSString*)anId
                     url:(NSString*)anUrl
{
    if (self=[self initWithConnection:aConnection name: aName ssid: anId]) {
        self.url = anUrl;
    }
    return self;
}


-(void) sendRequestWithSelfUrlAndMethod:(NSString*) method 
                      success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success 
                      failure:(void (^)(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON))failure
{
    [self sendRequestWithMethod:method path:self.url success: success failure:failure];
}



//http://localhost:3000/api/{method}/{self->ssid}
-(void) sendRequestWithMethod:(NSString*) method 
                      success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success 
                      failure:(void (^)(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON))failure
{
    [connection sendRequestWithString:[NSString stringWithFormat:@"api/%@/%@", method, self.ssid] success:success failure:failure];
}

//http://localhost:3000/api/{method}/{self->ssid}?{path}
-(void) sendRequestWithMethod:(NSString*) method path:(NSString*)path
                      success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success 
                      failure:(void (^)(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON))failure
{
    [connection sendRequestWithString:[NSString stringWithFormat:@"api/%@/%@?%@", method, self.ssid, path] success:success failure:failure];
}



@end
