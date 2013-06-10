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
#import "RallyLookbackArtifact.h"
#import "RallyWSAPIArtifact.h"
#import "FontAwesomeKit.h"

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
    [self showLoadingView];

//    [store loadArtifactsByScheduleState:@"In-Progress" success:^(RallyArtifactStore *artifactStore) {
//        UIActivityIndicatorView *loadIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:100];
//        [loadIndicator removeFromSuperview];
//        
//        [self.tableView reloadData];
//    }];
    
    [store loadArtifactsByProject:@279050021 withScheduleState:@"In-Progress" success:^(RallyArtifactStore *artifactStore) {
        [self removeLoadingView];
        
        [self.tableView reloadData];
    }];

    [self styleNavigationController];
    [self setNavigationIcons];
}

- (void)viewDidAppear:(BOOL)animated {
    
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

    RallyWSAPIArtifact *artifact = [store getArtifactByIndex:indexPath.row];
    NSString *name = [artifact getValueForKey:@"Name"];
    NSString *owner = [NSString stringWithFormat:@"Owned by: %@", [artifact getOwner]];
    
    [cell.artifactName setText:name];
    [cell.artifactOwner setText:owner];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ArtifactSummarySegue" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ArtifactSummarySegue"]) {
        ArtifactSummaryViewController *summaryViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

        RallyWSAPIArtifact *artifact = [store getArtifactByIndex:indexPath.row];
        summaryViewController.artifact = artifact;
    }
}

- (void)styleNavigationController {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)setNavigationIcons {
    UIImage *inFlight = [FontAwesomeKit imageForIcon:FAKIconRocket imageSize:CGSizeMake(30, 30) fontSize:20 attributes:nil];
    UIImage *recentActivity = [FontAwesomeKit imageForIcon:FAKIconBellAlt imageSize:CGSizeMake(30, 30) fontSize:20 attributes:nil];

    [self.displayControl setImage:inFlight forSegmentAtIndex:0];
    [self.displayControl setImage:recentActivity forSegmentAtIndex:1];
}

- (void)showLoadingView {
    UIActivityIndicatorView *loadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadIndicator.tag = 100;
    loadIndicator.center = self.view.center;
    [loadIndicator startAnimating];
    
    [self.view addSubview:loadIndicator];
}

- (void)removeLoadingView {
    UIActivityIndicatorView *loadIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:100];
    if(loadIndicator != nil) {
        [loadIndicator removeFromSuperview];
    }
}

@end
