//
//  VideoRecordViewController.h
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoRecordViewController : UIViewController <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblKeywords;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIView *viewRating;

- (IBAction)btnStartRecordClicked:(id)sender;
- (IBAction)btnRatingClicked:(id)sender;
- (IBAction)btnRatingConfirmed:(id)sender;

@end
