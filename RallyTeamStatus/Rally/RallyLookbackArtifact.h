//
//  RallyArtifact.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RallyArtifact.h"

@interface RallyLookbackArtifact : RallyArtifact

@property (nonatomic, strong) NSDictionary *values;

+ initWithValues:(NSDictionary *)values;

- (NSArray *)getChangedFields;

- (id)getValueForKey:(NSString *)key;

@end