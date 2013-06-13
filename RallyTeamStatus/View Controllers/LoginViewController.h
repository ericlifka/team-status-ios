//
//  LoginViewController.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/13/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *loginContainer;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) UITextField *activeTextField;

- (IBAction)onLoginButtonTouch:(id)sender;
- (IBAction)textFieldDidBeginEditing:(id)sender;
- (IBAction)onTextFieldTouch:(id)sender;

@end
