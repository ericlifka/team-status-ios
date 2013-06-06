//
//  RallyArtifact.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "RallyArtifact.h"

@implementation RallyArtifact

- (id) initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        self.name = name;
    }
    
    return self;
}
@end
