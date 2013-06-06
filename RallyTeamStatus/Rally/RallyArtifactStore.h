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

@class RallyArtifact;

@interface RallyArtifactStore : NSObject

@property (nonatomic, strong, readwrite) LookbackApiClient *lookbackClient;
@property (nonatomic, strong, readwrite) WSAPIClient *wsapiClient;

@property (nonatomic, strong, readwrite) NSMutableArray *artifactsInProgress;

+ (RallyArtifactStore *) instance;

- (NSInteger) itemsToDisplayCount;
- (RallyArtifact *) getArtifactByIndex:(NSInteger)index;
- (RallyArtifact *) getArtifactByObjectID:(NSString *)objectId;

- (void) loadArtifactsByScheduleState:(NSString *)state success:(void (^)(RallyArtifactStore *store))success;
@end

