//
//  ArtifactTableViewDataSource.m
//  RallyTeamStatus
//
//  Created by Pairing on 06/11/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ArtifactTableViewDataSource.h"
#import "RallyArtifactStore.h"
#import "RallyWSAPIArtifact.h"
#import "RallyLookbackArtifact.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtifactCell"];

    if (!cell) {
        cell = [UITableViewCell new];
    }

    RallyWSAPIArtifact *artifact = [wsapiStore getArtifactByIndex:indexPath.row];

    [cell.textLabel setText:[artifact getName]];
    [cell.detailTextLabel setText:[artifact getOwner]];
    return cell;
}

- (UITableViewCell *)inFlightTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtifactCell"];

    if (!cell) {
        cell = [UITableViewCell new];
    }

    RallyLookbackArtifact *artifact = [lookbackStore getArtifactByIndex:indexPath.row];
    NSString *name = [artifact getValueForKey:@"Name"];
    NSInteger numChangedFields = [[artifact getChangedFields] count];

    [cell.textLabel setText:name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Recently changed fields: %d", numChangedFields]];

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
