//
//  ViewController.m
//  RallyTeamStatus
//
//  Created by Pairing on 6/3/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonTouched:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    self.textField.text = [[NSString alloc] initWithFormat:@"Touched button: %@", button];
}
@end