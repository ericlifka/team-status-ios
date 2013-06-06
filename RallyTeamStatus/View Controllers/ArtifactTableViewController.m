//
//  ArtifactTableViewController.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/6/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ArtifactTableViewController.h"
#import "ArtifactSummaryViewController.h"

#import "RallyArtifactStore.h"
#import "RallyArtifact.h"

@interface ArtifactTableViewController ()

@end

@implementation ArtifactTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RallyArtifactStore *artifactStore = [RallyArtifactStore getSingleton];
    NSInteger itemsInTable = [artifactStore itemsToDisplayCount];
    
    return itemsInTable;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    RallyArtifactStore *artifactStore = [RallyArtifactStore getSingleton];
    RallyArtifact *artifact = [artifactStore getArtifactByIndex:indexPath.row];
    
    [cell.textLabel setText:artifact.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArtifactSummaryViewController *summaryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ArtifactSummaryViewController"];
    [self.navigationController pushViewController:summaryViewController animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Segue-ing");
}

@end
