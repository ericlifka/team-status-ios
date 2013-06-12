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

- (NSString *)artifactValueAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [[[tableView cellForRowAtIndexPath:indexPath] detailTextLabel] text];
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    CGSize constraintSize = CGSizeMake(tableView.frame.size.width, MAXFLOAT);
    CGSize labelSize = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return labelSize.height + 30;
}

- (UITableViewCell *)inProgressDetailTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    RallyWSAPIArtifact *artifact = (RallyWSAPIArtifact *)self.artifact;

    if(!cell) {
        cell = [UITableViewCell new];
    }

    NSString *field = [[artifact fieldsToDisplay] objectAtIndex:indexPath.row];
    cell.textLabel.text = field;

    id value = [artifact getValueForKey:field];
    if([value isKindOfClass:[NSNull class]] || value == nil) {
        value = @"None";
    }

    if([field isEqualToString:@"Owner"]) {
        value = [artifact getOwner];
    } else if([field isEqualToString:@"Name"]) {
        value = [artifact getName];
    }
    
    // Value is either a string or a number
    if(![value isKindOfClass:[NSString class]]) {
        value = [NSString stringWithFormat:@"%@", value];
    }
    
    if([field isEqualToString:@"Description"]) {
        NSMutableString *htmlString = [NSMutableString stringWithString:@"<html><head><title></title></head><body style=\"background:transparent;\">"];
        [htmlString appendString:value];
        [htmlString appendString:@"</body></html>"];
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:cell.frame];
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView loadHTMLString:htmlString baseURL:nil];
        
        cell.detailTextLabel.numberOfLines = 0;
        
        [cell.detailTextLabel setValue:value forKey:@"text"];
        
    } else {
        cell.detailTextLabel.text = value;
    }

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
