//
//  LoginViewController.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/13/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self updateContainer];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    [self.loginContainer addGestureRecognizer:tap];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateContainer {
    [self.loginContainer.layer setCornerRadius:5];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    UIScrollView *scrollView = (UIScrollView *)self.view;
    
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect frameRect = self.loginContainer.frame;
    frameRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(frameRect, self.activeTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y+keyboardSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIScrollView *scrollView = (UIScrollView *)self.view;

    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) dismissKeyboard {
    [self.activeTextField resignFirstResponder];
}

- (IBAction)onLoginButtonTouch:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.usernameTextField.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
    
    if(self.usernameTextField.text && self.passwordTextField.text) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)textFieldDidBeginEditing:(id)sender {
    self.activeTextField = (UITextField *)sender;
}

- (IBAction)onTextFieldTouch:(id)sender {
    self.activeTextField = (UITextField *)sender;
}
@end
