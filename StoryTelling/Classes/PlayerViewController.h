//
//  PlayerViewController.h
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblKeywords;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

- (IBAction)btnOKClicked:(id)sender;

@end
