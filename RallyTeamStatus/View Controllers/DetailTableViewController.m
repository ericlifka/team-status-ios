//
//  DetailTableViewController.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/12/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "DetailTableViewController.h"
#import "RallyArtifact.h"
#import "RallyWSAPIArtifact.h"
#import "RallyLookbackArtifact.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

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

- (BOOL)isLookbackView {
    return [self.artifact isMemberOfClass:[RallyLookbackArtifact class]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if([self isLookbackView]) {
        if(section == 0) {
            return @"Current Values";
        } else if(section == 1) {
            return @"Previous Values";
        } else { }
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self isLookbackView]) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.artifact fieldsToDisplay] count];
}

- (NSString *)stripHTMLFromString:(NSString *)string {
    NSRange r;
    NSString *copy = [string copy];
    while ((r = [copy rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        copy = [copy stringByReplacingCharactersInRange:r withString:@""];
    return copy;
}

- (NSString *)artifactValueAtIndexPath:(NSIndexPath *)indexPath {
    NSString *field = [[self.artifact fieldsToDisplay] objectAtIndex:indexPath.row];
    id value = [self.artifact getValueForKey:field];
    
    if(value == nil) {
        return @"None";
    } else if([value isKindOfClass:[NSNull class]]) {
        return @"None";
    } else if([field isEqualToString:@"Owner"]) {
        return [(RallyWSAPIArtifact *)self.artifact getOwner];
    } else if(![value isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@", value];
    }
    
    return [self stripHTMLFromString:value];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [self artifactValueAtIndexPath:indexPath];
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    CGSize constraintSize = CGSizeMake(tableView.frame.size.width, MAXFLOAT);
    CGSize labelSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return labelSize.height + 40;
}

- (UITableViewCell *)inProgressDetailTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    RallyWSAPIArtifact *artifact = (RallyWSAPIArtifact *)self.artifact;

    if(!cell) {
        cell = [UITableViewCell new];
    }

    NSString *field = [[artifact fieldsToDisplay] objectAtIndex:indexPath.row];
    cell.textLabel.text = field;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [self artifactValueAtIndexPath:indexPath];

    return cell;
}

- (UITableViewCell *)recentChangesDetailTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    RallyLookbackArtifact *artifact = (RallyLookbackArtifact *)self.artifact;
    NSDictionary *changedField = [[artifact getChangedFields] objectAtIndex:indexPath.row];

    if(!cell) {
        cell = [UITableViewCell new];
    }
    
    NSString *field = [changedField objectForKey:@"field"];
    NSLog(@"%d", [field rangeOfString:@"_"].location);
    if([field rangeOfString:@"_"].location == 0) {
        field = [field substringFromIndex:1];
    }
    cell.textLabel.text = field;
    
    if(indexPath.section == 0) {
        id newValue = [changedField objectForKey:@"newValue"];
        if(![newValue isKindOfClass:[NSString class]]) {
            newValue = [NSString stringWithFormat:@"%@", newValue];
        }
        cell.detailTextLabel.text = newValue;
    } else if(indexPath.section == 1) {
        id previousValue = [changedField objectForKey:@"previousValue"];
        if(![previousValue isKindOfClass:[NSString class]]) {
            previousValue = [NSString stringWithFormat:@"%@", previousValue];
        }
        cell.detailTextLabel.text = previousValue;
        
    }

    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.artifact isMemberOfClass:[RallyWSAPIArtifact class]]) {
        return [self inProgressDetailTableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        return [self recentChangesDetailTableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
