//
//  SSFile.h
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSItem.h"

@class SSFile;
@protocol SSFileDelegate <NSObject>
-(void) file:(SSFile*) file contentLoaded:(NSData*) content;
@end


@interface SSFile : SSItem
@property (retain) NSData* content;
@property (strong) id<SSFileDelegate> delegate;
-(void) loadContent;
@end
