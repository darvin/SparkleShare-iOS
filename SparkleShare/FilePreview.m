//
//  FilePreview.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FilePreview.h"
#import "SSFile.h"
#import "NSString+Hashing.h"

@implementation FilePreview
@synthesize filename = _filename, localURL=_localURL;
-(id) initWithFile:(SSFile*) file
{
    if (self = [super init]){
        self.filename = file.name;
        NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:[file.url sha1]];
        NSError *error;
        NSLog(@"Directory path: %@", path);
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])	//Does directory already exist?
        {
            if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                           withIntermediateDirectories:NO
                                                            attributes:nil
                                                                 error:&error])
            {
                NSLog(@"Create directory error: %@", error);
                self = nil;
                return self;
            }
        }
        
        NSString* tempFileName = [path stringByAppendingPathComponent:self.filename];
        NSLog(@"File path: %@", tempFileName);

        if (![[NSFileManager defaultManager] createFileAtPath:tempFileName
                                                contents:file.content
                                              attributes:nil])
        {
            NSLog(@"Create file error");
            self = nil;
            return self;
        } else {
            self.localURL = [NSURL URLWithString:tempFileName];
        }
    }
    return self;
}

- (NSURL *) previewItemURL
{
    return self.localURL;
}

- (NSString *) previewItemTitle
{
    return self.filename;
}

@end
