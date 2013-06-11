//
//  RallyWSAPIArtifact.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/7/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RallyWSAPIArtifact : NSObject

@property (nonatomic, strong) NSDictionary *values;

+ initWithValues:(NSDictionary *)values;
- (id)getValueForKey:(NSString *)key;
- (NSString *)getOwner;
- (NSNumber *)getObjectId;
- (NSString *)getName;

@end
