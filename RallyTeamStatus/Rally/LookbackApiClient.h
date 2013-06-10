//
//  LookbackApiClient.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/5/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>
#import <AFHTTPRequestOperation.h>

@interface LookbackApiClient : AFHTTPClient

+ (LookbackApiClient *)instance;

- (void)findQuery:(NSDictionary *)find forFields:(NSArray *)fields success:(void (^)(id responseObject))success;
- (void)findQuery:(NSDictionary *)find forFields:(NSArray *)fields withPageSize:(NSNumber *)pageSize andHydrate:(NSArray *)hydrate
          success:(void (^)(id responseObject))success;
- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

@end
