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

@interface WSAPIClient : AFHTTPClient

+ (WSAPIClient *)instance;
- (void)setUsername:(NSString *)username andPassword:(NSString *)password;
- (void)getStoriesForProject:(NSString *)project withScheduleState:(NSString *)state success:(void (^)(id responseObject))success;

@end
