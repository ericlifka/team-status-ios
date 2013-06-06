//
//  RallyArtifactStore.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "RallyArtifactStore.h"
#import "RallyArtifact.h"

@implementation RallyArtifactStore

+ (RallyArtifactStore *) getSingleton {
    static RallyArtifactStore *singleton = nil;
    
    if (!singleton) {
        singleton = [[super allocWithZone: nil] init];
    }
    
    return singleton;
}

+ (id) allocWithZone:(NSZone *)zone {
    return [self getSingleton];
}

- (id) init {
    self = [super init];
    
    if (self) {
        artifactsInProgress = [[NSMutableArray alloc] init];
        
        [artifactsInProgress addObject:[[RallyArtifact alloc] initWithName:@"Story A"]];
        [artifactsInProgress addObject:[[RallyArtifact alloc] initWithName:@"Story B"]];
        [artifactsInProgress addObject:[[RallyArtifact alloc] initWithName:@"Defect 1"]];
    }
    
    return self;
}

- (NSInteger) itemsToDisplayCount {
    return [artifactsInProgress count];
}

- (RallyArtifact *) getArtifactByIndex:(NSInteger)index {
    return [artifactsInProgress objectAtIndex:index];
}

@end
