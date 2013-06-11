//
//  WSAPIArtifactTableViewCell.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <CTCustomTableViewCell.h>

@interface WSAPIArtifactTableViewCell : CTCustomTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *artifactName;
@property (strong, nonatomic) IBOutlet UILabel *artifactStatus;

@end
