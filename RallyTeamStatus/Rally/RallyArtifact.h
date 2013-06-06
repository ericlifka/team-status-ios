//
//  RallyArtifact.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RallyArtifact : NSObject

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *description;
@property (nonatomic, strong, readwrite) NSString *owner;
@property (nonatomic, strong, readwrite) NSString *blockedReason;
@property (nonatomic, strong, readwrite) NSString *planEstimate;

- (id) initWithName:(NSString *)name;

@end