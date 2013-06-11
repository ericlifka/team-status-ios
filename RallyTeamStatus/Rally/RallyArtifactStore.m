//
//  RallyArtifactStore.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <AFHTTPRequestOperation.h>

#import "RallyArtifactStore.h"
#import "RallyLookbackArtifact.h"
#import "RallyWSAPIArtifact.h"

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
        self.artifacts = [[NSMutableArray alloc] init];
        
        self.lookbackClient = [LookbackApiClient instance];
        [self.lookbackClient setUsername:@"skendall@rallydev.com" andPassword:@"Password"];
        
        self.wsapiClient = [WSAPIClient instance];
        [self.wsapiClient setUsername:@"skendall@rallydev.com" andPassword:@"Password"];
    }
    
    return self;
}

- (NSInteger) itemsToDisplayCount {
    return [self.artifacts count];
}

- (id)getArtifactByIndex:(NSInteger)index {
    return [self.artifacts objectAtIndex:index];
}

- (id)getArtifactByObjectID:(NSNumber *)objectId {
    for(id artifact in self.artifacts) {
        if([[artifact getValueForKey:@"ObjectID"] isEqualToNumber:objectId]) {
            return artifact;
        }
    }
    
    return nil;
}

- (void)loadRecentSnapshotsForProject:(NSNumber *)project success:(void (^)(RallyArtifactStore *store))success {
    NSDictionary *find = @{
        @"Project": project
    };
    
    NSArray *fields = @[@"Name", @"ScheduleState", @"PlanEstimate", @"ObjectID", @"_ValidFrom", @"_ValidTo", @"Project", @"Owner"];
    NSArray *hydrate = @[@"ScheduleState"];
    
    [self.lookbackClient findQuery:find forFields:fields withPageSize:@10 andHydrate:hydrate success:^(id responseObject) {
        self.artifacts = [[NSMutableArray alloc] init];
        
        NSDictionary *json = (NSDictionary *)responseObject;
        NSArray *results = [json objectForKey:@"Results"];
        
        for(id result in results) {
            RallyLookbackArtifact * artifact = [RallyLookbackArtifact initWithValues:result];
            [self.artifacts addObject:artifact];
        }
        
        NSLog(@"%@", self.artifacts);
        
        success(self);
    }];
}

- (void) loadArtifactsByProject:(NSNumber *)project withScheduleState:(NSString *)state success:(void (^)(RallyArtifactStore *store))success {
    [self.wsapiClient getStoriesForProject:project withScheduleState:state success:^(id responseObject) {
        self.artifacts = [[NSMutableArray alloc] init];
        
        NSDictionary *json = (NSDictionary *)responseObject;
        NSDictionary *results = [[json objectForKey:@"QueryResult"] objectForKey:@"Results"];
        
        for(id result in results) {
            RallyWSAPIArtifact *artifact = [RallyWSAPIArtifact initWithValues:result];

            if([self getArtifactByObjectID:[artifact getObjectId]] == nil) {
                [self.artifacts addObject:artifact];
            }
        }

        success(self);
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
            RallyLookbackArtifact * artifact = [[RallyLookbackArtifact alloc] init];
            [artifact setValuesForKeysWithDictionary:result];
            [self.artifacts addObject:artifact];
        }
        
        NSLog(@"%@", self.artifacts);
        
        success(self);
    }];
}

@end
