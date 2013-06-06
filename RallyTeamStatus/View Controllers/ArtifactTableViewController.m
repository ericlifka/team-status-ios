//
//  ArtifactTableViewController.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ArtifactTableViewController.h"
#import "ArtifactSummaryViewController.h"
#import "ArtifactTableViewCell.h"

#import "RallyArtifactStore.h"
#import "RallyArtifact.h"

@interface ArtifactTableViewController ()

@end

@implementation ArtifactTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(store == nil) {
        store = [RallyArtifactStore instance];
    }

    [self.tableView setDataSource:self];

    [store loadArtifactsByScheduleState:@"In-Progress" success:^(RallyArtifactStore *artifactStore) {
        UIActivityIndicatorView *loadIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:100];
        [loadIndicator removeFromSuperview];
        
        [self.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [self showLoadingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger itemsInTable = [store itemsToDisplayCount];
    return itemsInTable;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArtifactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtifactTableViewCell"];
    
    if (!cell) {
        cell = [ArtifactTableViewCell create];
    }
    
    RallyArtifact *artifact = [store getArtifactByIndex:indexPath.row];
    NSString *name = [artifact valueForKey:@"Name"];
    NSString *owner = [[NSString alloc] initWithFormat:@"Owned by: %@", [artifact valueForKey:@"Owner"]];
    
    [cell.artifactName setText:name];
    [cell.artifactOwner setText:owner];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ArtifactSummarySegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Segue-ing");
}

- (void)showLoadingView {
    UIActivityIndicatorView *loadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadIndicator.tag = 100;
    loadIndicator.center = self.view.center;
    [loadIndicator startAnimating];
    
    [self.view addSubview:loadIndicator];
}

@end
