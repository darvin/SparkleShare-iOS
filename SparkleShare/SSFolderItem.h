//
//  SSFolderItem.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSFolder.h"
@interface SSFolderItem : NSObject
{
@private
    NSString* name;
    NSString* ssid;
    NSString* url;
    id<SSFolderDelegate> folder;
}

-(id) initWithFolder:(SSFolder*)aFolder
                    name:(NSString*)aName 
                    ssid:(NSString*)anId
                    url:(NSString*)anUrl;
-(NSData*) getDataWithMethod:(NSString*)method;
-(id*) getObjectWithMethod:(NSString*)method;

@property (readonly) NSString* name;
@property (readonly) NSString* ssid;
@property (readonly) NSString* url;
@property (nonatomic, strong) id<SSFolderDelegate> folder;
@end
