//
//  SSConnection.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSConnectionDelegate <NSObject>
-(NSData*) getDataWithRequest:(NSString*)request;
-(id*) getObjectWithRequest:(NSString*)request;
@end

@interface SSConnection : NSObject <SSConnectionDelegate>
{
@private
    NSURL* address;
    NSString* code;
    NSString* identCode;
    NSString* authCode;
    NSArray* folders;
    
    NSOperationQueue *queue;
}

@property (readonly) NSArray* folders;
@property (readonly) NSString* identCode;
@property (readonly) NSString* authCode;
@property (readonly) NSURL* address;
-(id) initWithAddress:(NSURL*)anAddress code:(NSString*)aCode;
-(id) initWithAddress:(NSURL*)anAddress identCode:(NSString*)anIdentCode authCode:(NSString*)anAuthCode;
-(id) initWithUserDefaults;
-(NSData*) getDataWithRequest:(NSString*)request;
-(id*) getObjectWithRequest:(NSString*)request;

@end
