//
//  RallyArtifactStore.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <AFHTTPRequestOperation.h>

#import "RallyArtifactStore.h"
#import "RallyArtifact.h"

@implementation RallyArtifactStore

+ (RallyArtifactStore *) instance {
    static RallyArtifactStore *singleton = nil;
    
    if (!singleton) {
        singleton = [[super allocWithZone: nil] init];
    }
    
    return singleton;
}

+ (id) allocWithZone:(NSZone *)zone {
    return [self instance];
}

- (id) init {
    self = [super init];
    
    if (self) {
        self.artifactsInProgress = [[NSMutableArray alloc] init];
        
        self.lookbackClient = [LookbackApiClient instance];
        [self.lookbackClient setUsername:@"skendall@rallydev.com" andPassword:@"Password"];
        
        self.wsapiClient = [WSAPIClient instance];
        [self.wsapiClient setUsername:@"skendall@rallydev.com" andPassword:@"Password"];
    }
    
    return self;
}

- (NSInteger) itemsToDisplayCount {
    return [self.artifactsInProgress count];
}

- (RallyArtifact *) getArtifactByIndex:(NSInteger)index {
    return [self.artifactsInProgress objectAtIndex:index];
}

- (RallyArtifact *) getArtifactByObjectID:(NSString *)objectId {
    for(id artifact in self.artifactsInProgress) {
        if([[artifact valueForKey:@"ObjectID"] isEqualToString:objectId]) {
            return artifact;
        }
    }
    
    return nil;
}

- (void) loadArtifactsByProject:(NSString *)project withScheduleState:(NSString *)state success:(void (^)(RallyArtifactStore *store))success {
    [self.wsapiClient getStoriesForProject:@"279050021" withScheduleState:@"In-Progress" success:^(id responseObject) {
        NSLog(@"%@", responseObject);
    }];
}

- (void) loadArtifactsByScheduleState:(NSString *)state success:(void (^)(RallyArtifactStore *store))success {
    NSDictionary *find = @{
        @"__At": @"current",
        @"_TypeHierarchy": @"HierarchicalRequirement",
        @"ScheduleState": state,
        @"Project": @279050021
    };
    
    NSArray *fields = @[@"Name", @"ScheduleState", @"PlanEstimate", @"ObjectID", @"_ValidFrom", @"_ValidTo", @"Project", @"Owner"];
    NSArray *hydrate = @[@"ScheduleState"];
    
    [self.lookbackClient findQuery:find forFields:fields withPageSize:@100 andHydrate:hydrate success:^(id responseObject) {
        NSDictionary *json = (NSDictionary *)responseObject;
        NSArray *results = [json objectForKey:@"Results"];
        
        for(id result in results) {
            RallyArtifact * artifact = [[RallyArtifact alloc] init];
            [artifact setValuesForKeysWithDictionary:result];
            [self.artifactsInProgress addObject:artifact];
        }
        
        NSLog(@"%@", self.artifactsInProgress);
        
        success(self);
    }];
}

@end
