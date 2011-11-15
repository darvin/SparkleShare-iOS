//
//  UIViewController+AutoPlatformXIB.m
//  SparkleShare
//
//  Created by Sergey Klimov on 15.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+AutoPlatformNibName.h"

@implementation UIViewController (AutoPlatformNibName)
-(id) initWithAutoPlatformNibName
{
    NSString* className = NSStringFromClass ([self class]);
    NSString* plaformSuffix;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        plaformSuffix = @"iPhone";
    } else {
        plaformSuffix = @"iPad";
    }
    return [self initWithNibName:[NSString stringWithFormat:@"%@_%@", className, plaformSuffix] bundle:nil];
}
@end
