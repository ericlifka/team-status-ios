//
//  ArtifactTableViewDataSource.m
//  RallyTeamStatus
//
//  Created by Pairing on 06/11/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ArtifactTableViewDataSource.h"
#import "RallyArtifactStore.h"
#import "WSAPIArtifactTableViewCell.h"
#import "RallyWSAPIArtifact.h"
#import "RallyLookbackArtifact.h"
#import "LookbackArtifactTableViewCell.h"

//NSInteger IN_FLIGHT = 0;
//NSInteger RECENT_ACTIVITY = 1;

@implementation ArtifactTableViewDataSource

- (id)init {
    self = [super init];
    if (self) {
        if(lookbackStore == nil) {
            lookbackStore = [RallyArtifactStore instance];
        }

        if(wsapiStore == nil) {
            wsapiStore = [RallyArtifactStore instance];
        }
    }

    return self;
}

- (RallyArtifactStore *)getCurrentStore {
    if(self.currentView == 0) {
        return wsapiStore;
    }

    if(self.currentView == 1) {
        return lookbackStore;
    }

    return nil;
}

- (UITableViewCell *)inProgressTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSAPIArtifactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSAPIArtifactTableViewCell"];

    if (!cell) {
        cell = [WSAPIArtifactTableViewCell create];
    }

    RallyWSAPIArtifact *artifact = [wsapiStore getArtifactByIndex:indexPath.row];
    NSString *name = [artifact getName];
    NSString *owner = [artifact getOwner];

    [cell.artifactName setText:name];
    [cell.artifactStatus setText:owner];
    return cell;
}

- (UITableViewCell *)inFlightTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LookbackArtifactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookbackArtifactTableViewCell"];

    if (!cell) {
        cell = [LookbackArtifactTableViewCell create];
    }

    RallyLookbackArtifact *artifact = [lookbackStore getArtifactByIndex:indexPath.row];
    NSString *name = [artifact getValueForKey:@"Name"];
    NSInteger numChangedFields = [[artifact getChangedFields] count];

    [cell.artifactName setText:name];
    [cell.fieldsCount setText:[NSString stringWithFormat:@"Recently changed fields: %d", numChangedFields]];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getCurrentStore] itemsToDisplayCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.currentView == 0) {
        return [self inProgressTableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        return [self inFlightTableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
