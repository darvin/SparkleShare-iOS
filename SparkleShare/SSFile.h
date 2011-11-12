//
//  SSFile.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSFolderItem.h"

@class SSFile;
@protocol SSFileDelegate <NSObject>
-(void) file:(SSFile*) file contentLoaded:(NSData*) content;
@end


@interface SSFile : SSFolderItem
@property (readonly) NSData* content;
@end
