//
//  VideoRecordViewController.h
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoRecordViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTopic;
@property (weak, nonatomic) IBOutlet UILabel *lblCondition;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIView *viewRating;
@property (weak, nonatomic) IBOutlet UIView *viewTopic;
@property (weak, nonatomic) IBOutlet UIView *viewCondition;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;
@property (strong, nonatomic) NSTimer *timer;

- (IBAction)btnRatingClicked:(id)sender;
- (IBAction)btnRatingConfirmed:(id)sender;

@end
