//
//  FileSizeFormatter.h
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSizeFormatter : NSNumberFormatter
{
	@private
	BOOL useBaseTenUnits;
}

/** Flag signaling whether to calculate file size in binary units (1024) or base ten units (1000).  Default is binary units. */
@property (nonatomic, readwrite, assign, getter = isUsingBaseTenUnits) BOOL useBaseTenUnits;
- (NSString *)stringFromNumber: (NSNumber *)number;

@end