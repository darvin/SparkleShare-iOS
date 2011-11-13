//
//  SSJSONRequestOperation.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSJSONRequestOperation.h"

@implementation SSJSONRequestOperation

+ (SSJSONRequestOperation *)JSONRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                                    success:(void (^)(NSURLRequest *request, NSURLResponse *response, id JSON))success 
                                                    failure:(void (^)(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON))failure
{
    SSJSONRequestOperation *requestOperation = [[self alloc] initWithRequest:urlRequest];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation.request, operation.response, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation.request, operation.response, error, [(AFJSONRequestOperation *)operation responseJSON]);
        }
    }];
    
    return requestOperation;
}


- (id)initWithRequest:(NSURLRequest *)urlRequest {
    self = [super initWithRequest:urlRequest];
    if (!self) {
        return nil;
    }
    return self;
}

- (id)responseJSON {
    id responce = [super responseJSON];
    if (!responce){
        NSString* rawData = [[NSString alloc] initWithData:self.responseData
                                                  encoding:NSUTF8StringEncoding];
        if ([rawData hasPrefix:@"\""]&&[rawData hasSuffix:@"\""]) {
            responce = [rawData substringWithRange:NSMakeRange(1, [rawData length]-2)];
        }
        else
        {
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            NSNumber* numberResponce = [f numberFromString:rawData];
            if (numberResponce)
                responce = numberResponce;
            else
                responce = self.responseData;
        }
    }
    return responce;
}



@end
