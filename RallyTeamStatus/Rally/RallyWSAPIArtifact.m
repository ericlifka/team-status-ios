//
//  RallyWSAPIArtifact.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "RallyWSAPIArtifact.h"

@implementation RallyWSAPIArtifact

+ initWithValues:(NSDictionary *)values {
    RallyWSAPIArtifact *artifact = [[self alloc] init];
    artifact.values = values;
    return artifact;
}

- (id)getValueForKey:(NSString *)key {
    return [self.values objectForKey:key];
}

- (NSString *)getOwner {
    id owner = [self getValueForKey:@"Owner"];
    if(owner != nil) {
        if([owner isKindOfClass:[NSString class]] && [owner isEqualToString:@"<null>"]) {
            return @"None";
        }

        if([owner isKindOfClass:[NSDictionary class]]) {
            return [owner objectForKey:@"_refObjectName"];
        }
    }

    return @"None";
}

@end
