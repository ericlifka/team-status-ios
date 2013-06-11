//
//  ArtifactTableViewDataSource.h
//  RallyTeamStatus
//
//  Created by Pairing on 06/11/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

@class RallyArtifactStore;

@interface ArtifactTableViewDataSource : NSObject <UITableViewDataSource> {
    RallyArtifactStore *lookbackStore;
    RallyArtifactStore *wsapiStore;
}

@property (nonatomic) NSInteger currentView;

- (RallyArtifactStore *)getCurrentStore;

@end
