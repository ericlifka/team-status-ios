//
//  LoginViewController.m
//  RallyTeamStatus
//
//  Created by Omar Estrella on 6/5/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButtonTouch:(id)sender forEvent:(UIEvent *)event {
    // Auth against WSAPI
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
