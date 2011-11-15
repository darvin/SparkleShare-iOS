//
//  GitInfoFormatter.h
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitInfoFormatter : NSFormatter
+ (NSString *)stringFromGitRevision: (NSString *) revision;

@end