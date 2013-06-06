//
//  RallyArtifactStore.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RallyArtifact;

@interface RallyArtifactStore : NSObject
{
    NSMutableArray *artifactsInProgress;
}

+ (RallyArtifactStore *) getSingleton;

- (NSInteger) itemsToDisplayCount;
- (RallyArtifact *) getArtifactByIndex:(NSInteger)index;
@end

