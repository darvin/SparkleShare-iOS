//
//  SSConnection.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSConnection : NSObject
{
@private
    NSString* address;
    NSString* code;
    NSString* identCode;
    NSString* authCode;
    NSArray* folders;
}

@property (readonly) NSArray* folders;
@property (readonly) NSString* identCode;
@property (readonly) NSString* authCode;
@property (readonly) NSString* address;
-(id) initWithAddress:(NSString*)anAddress code:(NSString*)aCode;
-(id) initWithAddress:(NSString*)anAddress identCode:(NSString*)anIdentCode authCode:(NSString*)anAuthCode;
-(NSData*) getDataWithRequest:(NSString*)request;
-(id*) getObjectWithRequest:(NSString*)request;

@end
