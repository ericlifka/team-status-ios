//
//  LookbackArtifactTableViewCell.m.h
//  RallyTeamStatus
//
//  Created by Pairing on 06/11/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@interface LookbackArtifactTableViewCell : CTCustomTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *artifactName;
@property (strong, nonatomic) IBOutlet UILabel *fieldsCount;

@end
