//
//  ResultViewController.h
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblResult;

- (IBAction)btnOKClicked:(id)sender;
@end
