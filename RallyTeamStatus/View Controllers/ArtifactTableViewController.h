//
//  ArtifactTableViewController.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RallyArtifactStore.h"

@class ArtifactTableViewDataSource;

@interface ArtifactTableViewController : UITableViewController {
    ArtifactTableViewDataSource<UITableViewDataSource> *artifactDataSource;
}

- (IBAction)onControlValueChanged:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *displayControl;

@end
