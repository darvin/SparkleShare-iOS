//
//  FileSizeFormatter.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FileSizeFormatter.h"

static const char sUnits[] = {
	'\0', 'K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y'
};
static int sMaxUnits = sizeof sUnits - 1;

@implementation FileSizeFormatter

@synthesize useBaseTenUnits;

- (NSString *) stringFromNumber: (NSNumber *) number {
	int multiplier = useBaseTenUnits ? 1000 : 1024;
	int exponent = 0;

	double bytes = [number doubleValue];

	while ( (bytes >= multiplier) && (exponent < sMaxUnits) ) {
		bytes /= multiplier;
		exponent++;
	}

	return [NSString stringWithFormat: @"%@ %cB", [super stringFromNumber: [NSNumber numberWithDouble: bytes]], sUnits[exponent]];
}

@end