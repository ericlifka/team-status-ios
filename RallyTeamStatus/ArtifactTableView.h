//
// Created by Pairing on 6/11/13.
// Copyright (c) 2013 Rally Software. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RallyArtifactStore;


@interface ArtifactTableView : UITableView

@property (nonatomic, strong) RallyArtifactStore *store;

@end