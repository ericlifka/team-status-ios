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
#import "ArtifactTableViewDataSource.h"
#import "RallyLookbackArtifact.h"
#import "RallyWSAPIArtifact.h"
#import "FontAwesomeKit.h"
#import "ArtifactTableViewDataSource.h"

NSInteger IN_FLIGHT = 0;
NSInteger RECENT_ACTIVITY = 1;

NSInteger SEGMENTED_CONTROL_TAG = 10;
NSInteger LOADING_INDICATOR_TAG = 100;

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

    artifactDataSource = [ArtifactTableViewDataSource new];
    [self.tableView setDataSource:artifactDataSource];
    [self.tableView setDelegate:self];

//    [store loadArtifactsByScheduleState:@"In-Progress" success:^(RallyArtifactStore *artifactStore) {
//        UIActivityIndicatorView *loadIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:100];
//        [loadIndicator removeFromSuperview];
//        
//        [self.tableView reloadData];
//    }];

    [self loadArtifactsInProgress];
    [self styleNavigationController];
    [self setNavigationIcons];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ArtifactSummarySegue" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ArtifactSummarySegue"]) {
        ArtifactSummaryViewController *summaryViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

//        RallyWSAPIArtifact *artifact = [store getArtifactByIndex:indexPath.row];
//        summaryViewController.artifact = artifact;
    }
}

- (RallyArtifactStore *)getStore {
    return [artifactDataSource getCurrentStore];
}

- (void)loadArtifactsInProgress {
    [self showLoadingView];

    [[self getStore] loadArtifactsByProject:@279050021 withScheduleState:@"In-Progress" success:^(RallyArtifactStore *artifactStore) {
        [self removeLoadingView];

        [self.tableView reloadData];
    }];
}

- (void)loadRecentActivityStream {
    [self showLoadingView];

    [[self getStore] loadRecentSnapshotsForProject:@279050021 success:^(RallyArtifactStore *artifactStore) {
        [self removeLoadingView];

        [self.tableView reloadData];
    }];
}

- (void)styleNavigationController {
    
}

- (void)setNavigationIcons {
    UIImage *inFlight = [FontAwesomeKit imageForIcon:FAKIconRocket imageSize:CGSizeMake(30, 30) fontSize:20 attributes:nil];
    UIImage *recentActivity = [FontAwesomeKit imageForIcon:FAKIconCalendar imageSize:CGSizeMake(30, 30) fontSize:20 attributes:nil];

    [self.displayControl setImage:inFlight forSegmentAtIndex:0];
    [self.displayControl setImage:recentActivity forSegmentAtIndex:1];
}

- (void)showLoadingView {
    UIActivityIndicatorView *loadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadIndicator.tag = LOADING_INDICATOR_TAG;
    loadIndicator.center = self.view.center;
    [loadIndicator startAnimating];
    
    [self.view addSubview:loadIndicator];
}

- (void)removeLoadingView {
    UIActivityIndicatorView *loadIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:LOADING_INDICATOR_TAG];
    if(loadIndicator != nil) {
        [loadIndicator removeFromSuperview];
    }
}

- (IBAction)onControlValueChanged:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;

    artifactDataSource.currentView = control.selectedSegmentIndex;

    if(control.selectedSegmentIndex == IN_FLIGHT) {
        [self loadArtifactsInProgress];
    }

    if(control.selectedSegmentIndex == RECENT_ACTIVITY) {
        [self loadRecentActivityStream];
    }
}
@end
