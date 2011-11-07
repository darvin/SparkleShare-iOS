//
//  SSFolderItem.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFolderItem.h"

@implementation SSFolderItem
@synthesize name, ssid, url;

-(id) initWithFolder:(SSFolder*)aFolder
                name:(NSString*)aName 
                ssid:(NSString*)anId
                 url:(NSString*)anUrl
{
    self=[self init];
    folder = aFolder;
    name = aName;
    ssid = anId;
    url = anUrl;
    return self;
}

-(NSData*) getDataWithMethod:(NSString*)method
{
    return [folder getDataWithMethod:method path:url];
}

-(id*) getObjectWithMethod:(NSString*)method
{
    return [folder getObjectWithMethod:method path:url];
}

@end
