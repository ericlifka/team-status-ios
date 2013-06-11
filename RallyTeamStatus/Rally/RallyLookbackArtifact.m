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

- (NSArray *)getChangedFields {
    NSMutableArray *changedFields = [NSMutableArray new];
    NSDictionary *previousValues = [self getValueForKey:@"_PreviousValues"];

    for(id key in [previousValues allKeys]) {
        NSMutableDictionary *object = [NSMutableDictionary new];
        [object setObject:key forKey:@"field"];
        [object setObject:[previousValues objectForKey:key] forKey:@"previousValue"];
        [object setObject:[self getValueForKey:key] forKey:@"newValue"];
        [changedFields addObject:object];
    }

    return changedFields;
}

- (id)getValueForKey:(NSString *)key {
    return [self.values objectForKey:key];
}

@end
