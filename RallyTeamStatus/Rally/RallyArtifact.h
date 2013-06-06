//
//  RallyArtifact.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RallyArtifact : NSObject

@property (nonatomic, strong, readwrite) NSString *Name;
@property (nonatomic, strong, readwrite) NSString *ScheduleState;
@property (nonatomic, strong, readwrite) NSNumber *PlanEstimate;
@property (nonatomic, strong, readwrite) NSString *ObjectID;
@property (nonatomic, strong, readwrite) NSString *_ValidFrom;
@property (nonatomic, strong, readwrite) NSString *_ValidTo;
@property (nonatomic, strong, readwrite) NSNumber *Project;
@property (nonatomic, strong, readwrite) NSNumber *Owner;

@property (nonatomic, strong, readwrite) NSString *blockedReason;

@end