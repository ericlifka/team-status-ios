//
//  RallyArtifact.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "RallyLookbackArtifact.h"

@implementation RallyLookbackArtifact

+ initWithValues:(NSDictionary *)values {
    RallyLookbackArtifact *artifact = [[self alloc] init];
    artifact.values = values;
    return artifact;
}

- (id)getValueForKey:(NSString *)key {
    return [self.values objectForKey:key];
}

@end
