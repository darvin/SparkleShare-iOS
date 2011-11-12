//
//  SSConnection.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSConnection.h"
#import "AFNetworking.h"
#import "TTTURLRequestFormatter.h"
@interface SSConnection ()
-(void) testConnection;
@end

@implementation SSConnection
@synthesize identCode, authCode, address, delegate;

-(id) init
{
    if (self = [super init]){
        queue = [[NSOperationQueue alloc] init];
    }
    return self;
}


-(id) initWithAddress:(NSURL*)anAddress identCode:(NSString*)anIdentCode authCode:(NSString*)anAuthCode
{
    self=[self init];
    address = anAddress;
    authCode = anAuthCode;
    identCode = anIdentCode;
    [self testConnection];
    return self;
}

-(id) initWithUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults URLForKey:@"link"]){
        [self.delegate connectionEstablishingFailed:self];
        self = nil;
    }
    else
        self = [self initWithAddress:[userDefaults URLForKey:@"link"] identCode:[userDefaults objectForKey:@"identCode"] authCode:[userDefaults objectForKey:@"authCode"]];
    return self;
}

//$ curl --data "code=286685&name=My%20Name" http://localhost:3000/api/getAuthCode
//{"ident":"qj7cGswA","authCode":"iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-"}
-(void) linkDeviceWithAddress:(NSURL*)anAddress code:(NSString*)code
{
    address = anAddress;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[address URLByAppendingPathComponent:  @"api/getAuthCode"]];
    [request setHTTPMethod:@"POST"];
    NSString* requestString = [NSString stringWithFormat:@"code=%@&name=%@",
                               [code stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                               [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
    [request setHTTPBody: requestData];

    NSLog(@"%@", [TTTURLRequestFormatter cURLCommandFromURLRequest:request]);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON) {
        identCode = [JSON valueForKey:@"ident"];
        authCode = [JSON valueForKey:@"authCode"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:identCode forKey:@"identCode"];
        [userDefaults setObject:authCode forKey:@"authCode"];
        [userDefaults setURL:address forKey:@"link"];
        [userDefaults setBool:YES forKey:@"linked"];
        [userDefaults removeObjectForKey:@"code"];
        
        [userDefaults synchronize];
        [self.delegate connectionEstablishingSuccess:self];
    } failure:^( NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON ){
        [self.delegate connectionEstablishingFailed:self];
    }];
    
    [queue addOperation:operation];
    
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
}

-(id*) getObjectWithRequest:(NSString*)request
{

}

-(void) sendRequestWithString:(NSString*) string 
                      success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success 
                      failure:(void (^)(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[address URLByAppendingPathComponent:  string]];
    [request setValue:identCode forHTTPHeaderField:@"X-SPARKLE-IDENT"];
    [request setValue:authCode forHTTPHeaderField:@"X-SPARKLE-AUTH"];
    
    NSLog(@"%@", [TTTURLRequestFormatter cURLCommandFromURLRequest:request]);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:success
     failure:failure];
    
    [queue addOperation:operation];

}

-(void) testConnection
{
    [self sendRequestWithString:@"api/getFolderList" 
                        success:
        ^(NSURLRequest *request, NSURLResponse *response, id JSON) {
            NSLog(@"%@ %@", response, JSON);
            [self.delegate connectionEstablishingSuccess:self];
        } 
                        failure:
        ^( NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON ){
            NSLog(@"%@ %@", response, error);
        
            [self.delegate connectionEstablishingFailed:self];
        } ];
}


@end
