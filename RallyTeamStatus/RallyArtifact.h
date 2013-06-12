//
// Created by Pairing on 6/12/13.
// Copyright (c) 2013 Rally Software. All rights reserved.
//
//


#import <Foundation/Foundation.h>


@interface RallyArtifact : NSObject

- (NSArray *)fieldsToDisplay;
- (id)getValueForKey:(NSString *)key;

@property (nonatomic, strong) NSDictionary *values;

@end