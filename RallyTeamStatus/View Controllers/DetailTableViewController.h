//
//  DetailTableViewController.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/12/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RallyArtifact;

@interface DetailTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) RallyArtifact *artifact;

@end
