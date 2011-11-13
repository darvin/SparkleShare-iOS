//
//  SSJSONRequestOperation.h
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface SSJSONRequestOperation : AFHTTPRequestOperation {
@private
    id _responseJSON;
    NSError *_JSONError;
}

@property (readonly, nonatomic, retain) id responseJSON;


+ (SSJSONRequestOperation *)JSONRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                                    success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success 
                                                    failure:(void (^)(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON))failure;

@end
