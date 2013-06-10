//
//  ArtifactTableViewController.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RallyArtifactStore.h"

@interface ArtifactTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    RallyArtifactStore *store;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *displayControl;

@end
