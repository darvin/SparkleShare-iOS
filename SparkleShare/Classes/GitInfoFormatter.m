//
//  GitInfoFormatter.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GitInfoFormatter.h"

@implementation GitInfoFormatter
+ (NSString *)stringFromGitRevision: (NSString *) revision {
	return [revision substringToIndex: 11];
}

@end