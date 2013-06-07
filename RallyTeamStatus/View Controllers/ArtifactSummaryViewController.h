//
//  ArtifactViewController.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RallyWSAPIArtifact;

@interface ArtifactSummaryViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *formattedIdLabel;

@property (nonatomic, strong) RallyWSAPIArtifact *artifact;

@end
