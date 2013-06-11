//
//  RallyArtifactStore.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LookbackApiClient.h"
#import "WSAPIClient.h"

@class RallyLookbackArtifact;
@class RallyWSAPIArtifact;

@interface RallyArtifactStore : NSObject

@property (nonatomic, strong, readwrite) LookbackApiClient *lookbackClient;
@property (nonatomic, strong, readwrite) WSAPIClient *wsapiClient;

@property (nonatomic, strong, readwrite) NSMutableArray *artifacts;

+ (RallyArtifactStore *) instance;

- (NSInteger) itemsToDisplayCount;
- (id)getArtifactByIndex:(NSInteger)index;
- (id)getArtifactByObjectID:(NSNumber *)objectId;

- (void) loadRecentSnapshotsForProject:(NSNumber *)project success:(void (^)(RallyArtifactStore *store))success;
- (void) loadArtifactsByScheduleState:(NSString *)state success:(void (^)(RallyArtifactStore *store))success;
- (void) loadArtifactsByProject:(NSNumber *)project withScheduleState:(NSString *)state success:(void (^)(RallyArtifactStore *store))success;

@end

