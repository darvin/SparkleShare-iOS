//
//  SSConnection.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SSConnection;

@protocol SSConnectionDelegate <NSObject>
-(void) connectionEstablishingSuccess:(SSConnection*) connection;
-(void) connectionEstablishingFailed:(SSConnection*) connection;
@end

@protocol SSConnectionFoldersDelegate <NSObject>
-(void) connection:(SSConnection*) connection foldersLoaded:(NSArray*) folders;
@end

@interface SSConnection : NSObject
{
@private
    NSURL* address;
    NSString* identCode;
    NSString* authCode;
    NSArray* folders;
    NSOperationQueue *queue;
    id<SSConnectionDelegate> delegate;
}

@property (readonly) NSArray* folders;
@property (readonly) NSString* identCode;
@property (readonly) NSString* authCode;
@property (readonly) NSURL* address;
@property (strong, retain) id<SSConnectionDelegate> delegate;
-(id) initWithAddress:(NSURL*)anAddress identCode:(NSString*)anIdentCode authCode:(NSString*)anAuthCode;
-(id) initWithUserDefaults;
-(NSData*) getDataWithRequest:(NSString*)request;
-(id*) getObjectWithRequest:(NSString*)request;
-(void) linkDeviceWithAddress:(NSURL*)anAddress code:(NSString*)aCode;
@end
