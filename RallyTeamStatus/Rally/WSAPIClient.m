//
//  LookbackApiClient.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/5/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <AFHTTPClient.h>
#import <AFJSONRequestOperation.h>
#import <AFNetworkActivityIndicatorManager.h>

#import "WSAPIClient.h"

@implementation WSAPIClient

+ (WSAPIClient *)instance {
    static dispatch_once_t pred;
    static WSAPIClient *instance = nil;
    
    NSString *DEFAULT_URL = @"https://rally1.rallydev.com/slm/webservice/v2.0";
    
    dispatch_once(&pred, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:DEFAULT_URL]];
    });
    
    return instance;
}

- (void)setUsername:(NSString *)username andPassword:(NSString *)password {
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:username password:password];
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self)
        return nil;
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setParameterEncoding:AFJSONParameterEncoding];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

- (void)getStoriesForProject:(NSNumber *)project withScheduleState:(NSString *)state success:(void (^)(id responseObject))success {
    NSMutableDictionary *requestData = [[NSMutableDictionary alloc] init];
    
    NSArray *fetchFields = @[@"Name", @"ScheduleState", @"PlanEstimate", @"ObjectID", @"Project", @"Owner", @"FormattedID"];
    
    [requestData setObject:[fetchFields componentsJoinedByString:@","] forKey:@"fetch"];
    [requestData setObject:[NSString stringWithFormat:@"/project/%@", project] forKey:@"project"];
    [requestData setObject:[NSString stringWithFormat:@"(ScheduleState = %@)", state] forKey:@"query"];

    [self getPath:@"hierarchicalrequirement" parameters:requestData
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              success(responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"There was an error with your request: %@", error);
              raise(1);
          }];
}

@end