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

#import "LookbackApiClient.h"

NSString * const DEFAULT_URL = @"https://rally1.rallydev.com/analytics/v2.0/service/rally/workspace/41529001/artifact/snapshot";

@implementation LookbackApiClient

+ (LookbackApiClient *)instance {
    static dispatch_once_t pred;
    static LookbackApiClient *instance = nil;
    
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

- (void)findQuery:(NSDictionary *)find forFields:(NSArray *)fields success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success {
    [self findQuery:find forFields:fields withPageSize:[[NSNumber alloc] initWithInt:20000] andHydrate:@[] success:success];
}

- (void)findQuery:(NSDictionary *)find forFields:(NSArray *)fields withPageSize:(NSNumber *)pageSize andHydrate:(NSArray *)hydrate
          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success {
    
    NSMutableDictionary *requestData = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    [requestData setObject:find forKey:@"find"];
    [requestData setObject:fields forKey:@"fields"];
    [requestData setObject:pageSize forKey:@"pagesize"];
    [requestData setObject:hydrate forKey:@"hydrate"];
    
    [self requestWithData:requestData success:success];
    
}

- (void)requestWithData:(NSMutableDictionary *)requestData success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success {
    [self postPath:@"query.js" parameters:requestData success:success
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"There was an error with your request: %@", error);
               raise(1);
           }];
}

@end