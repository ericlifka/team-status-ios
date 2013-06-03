//
//  ViewController.h
//  RallyTeamStatus
//
//  Created by Pairing on 6/3/13.
//  Copyright (c) 2013 Rally Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)ButtonTouched:(id)sender;

@end
