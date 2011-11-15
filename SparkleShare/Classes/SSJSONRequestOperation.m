//
//  SSJSONRequestOperation.m
//  SparkleShare
//
//  Created by Sergey Klimov on 13.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "SSJSONRequestOperation.h"
#import "AFJSONUtilities.h"

static dispatch_queue_t af_json_request_operation_processing_queue;
static dispatch_queue_t json_request_operation_processing_queue() {
	if (af_json_request_operation_processing_queue == NULL) {
		af_json_request_operation_processing_queue = dispatch_queue_create("com.alamofire.networking.json-request.processing", 0);
	}

	return af_json_request_operation_processing_queue;
}

@interface SSJSONRequestOperation ()
@property (readwrite, nonatomic, retain) id responseJSON;
@property (readwrite, nonatomic, retain) NSError *JSONError;

@end

@implementation SSJSONRequestOperation
@synthesize responseJSON = _responseJSON;
@synthesize JSONError = _JSONError;

+ (SSJSONRequestOperation *)JSONRequestOperationWithRequest: (NSURLRequest *) urlRequest
       success: ( void (^)(NSURLRequest * request, NSURLResponse * response, id JSON) ) success
       failure: ( void (^)(NSURLRequest * request, NSURLResponse * response, NSError * error, id JSON) ) failure {
	SSJSONRequestOperation *requestOperation = [[[self alloc] initWithRequest: urlRequest] autorelease];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * operation, id responseObject) {
	         if (success) {
	                 success (operation.request, operation.response, responseObject);
		 }
	 }
	 failure:^(AFHTTPRequestOperation * operation, NSError * error) {
	         if (failure) {
	                 failure (operation.request, operation.response, error, [(SSJSONRequestOperation *) operation responseJSON]);
		 }
	 }
	];

	return requestOperation;
}


+ (BOOL)canProcessRequest: (NSURLRequest *) request {
	return YES;
}

- (id)initWithRequest: (NSURLRequest *) urlRequest {
	self = [super initWithRequest: urlRequest];
	if (!self) {
		return nil;
	}


	return self;
}

- (void)dealloc {
	[_responseJSON release];
	[_JSONError release];
	[super dealloc];
}

- (id)responseJSON {
	if (!_responseJSON && [self isFinished]) {
		NSError *error = nil;

		if ([self.responseData length] == 0) {
			self.responseJSON = nil;
		}
		else {
			self.responseJSON = AFJSONDecode(self.responseData, &error);
		}

		self.JSONError = error;
	}

	if (!_responseJSON) {
		id responce;
		NSString *rawData = [[NSString alloc] initWithData: self.responseData
		                     encoding: NSUTF8StringEncoding];
		if ([rawData hasPrefix: @"\""] && [rawData hasSuffix: @"\""]) {
			responce = [rawData substringWithRange: NSMakeRange(1, [rawData length] - 2)];
		}
		else {
			NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
			NSNumber *numberResponce = [f numberFromString: rawData];
			[f release];
			if (numberResponce)
				responce = numberResponce;
			else
				responce = self.responseData;
		}
		[rawData release];

		return responce;
	}
	else {
		return _responseJSON;
	}
}

- (NSError *)error {
	if (_JSONError) {
		return _JSONError;
	}
	else {
		return [super error];
	}
}

- (void)setCompletionBlockWithSuccess: ( void (^)(AFHTTPRequestOperation * operation, id responseObject) ) success
       failure: ( void (^)(AFHTTPRequestOperation * operation, NSError * error) ) failure {
	self.completionBlock = ^ {
		if ([self isCancelled]) {
			return;
		}

		if (self.error) {
			if (failure) {
				dispatch_async (dispatch_get_main_queue (), ^(void) {
				                        failure (self, self.error);
						}
				                );
			}
		}
		else {
			dispatch_async (json_request_operation_processing_queue (), ^(void) {
			                        id JSON = self.responseJSON;

			                        dispatch_async (dispatch_get_main_queue (), ^(void) {
			                                                if (self.JSONError) {
			                                                        if (failure) {
			                                                                failure (self, self.JSONError);
										}
									}
			                                                else {
			                                                        if (success) {
			                                                                success (self, JSON);
										}
									}
								}
			                                        );
					}
			                );
		}
	};
}

@end