//
//  ArtifactTableViewController.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/3/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtifactTableViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *dataArray;
}

@property (strong, nonatomic) NSMutableArray *dataArray;

@end
