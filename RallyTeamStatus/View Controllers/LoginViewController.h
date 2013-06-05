//
//  LoginViewController.h
//  RallyTeamStatus
//
//  Created by Omar Estrella on 6/5/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

- (IBAction)onLoginButtonTouch:(id)sender forEvent:(UIEvent *)event;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
