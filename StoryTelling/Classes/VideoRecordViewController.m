//
//  VideoRecordViewController.m
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import "VideoRecordViewController.h"
#import "AppDataManager.h"
#import "Utility.h"
#import "PlayerViewController.h"
#import "ResultViewController.h"

#define RATING_BUTTON_TAG_BASE  101
#define TOTAL_TIME_LEFT         9*60   // 19 mins = 15 mins for preparation + 4 mins for recording
#define TIMER_INTERVAL          10

@interface VideoRecordViewController ()
{
    AppDataManager  *m_appDataManager;
    UIImagePickerController *m_videoPicker;
    NSInteger       m_timeLeft;
    BOOL            m_isPresentingVideoPicker;
}

- (void)rateVideo:(NSInteger)rating;
- (void)btnQuitClicked:(id)sender;
- (void)timerFired:(id)sender;
- (void)showCondition;
- (void)showPrepareTimeUp;
- (void)showOneMinuteLeft;
- (void)startRecording;
- (void)stopRecording;

@end

@implementation VideoRecordViewController
@synthesize lblTopic;
@synthesize lblCondition;
@synthesize btnStart;
@synthesize viewRating;
@synthesize viewTopic;
@synthesize viewCondition;
@synthesize lblTimer;
@synthesize timer;

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
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"退出游戏" style:UIBarButtonItemStylePlain target:self action:@selector(btnQuitClicked:)];
    self.navigationItem.leftBarButtonItem = barButton;
    
    m_appDataManager = [AppDataManager sharedAppDataManager];
    m_videoPicker = [[UIImagePickerController alloc] init];
    m_isPresentingVideoPicker = NO;
}

- (void)viewDidUnload
{
    [self setBtnStart:nil];
    [self setViewRating:nil];
    [self setLblTopic:nil];
    [self setLblCondition:nil];
    [self setViewTopic:nil];
    [self setViewCondition:nil];
    [self setLblTimer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [m_appDataManager currentPlayerName];
    
    if ( !m_isPresentingVideoPicker )
    {
        self.btnStart.hidden = NO;
        self.viewTopic.hidden = NO;
        self.viewRating.hidden = YES;
        self.viewCondition.hidden = YES;
        
        self.lblTopic.text = [m_appDataManager currentTopic];
        self.lblCondition.text = @"";
        
        if ( self.timer == nil )
        {
            m_timeLeft = TOTAL_TIME_LEFT;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
            [self.timer fire];
        }
    }
    else 
    {
        m_isPresentingVideoPicker = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ( !m_isPresentingVideoPicker )
    {
        [self.timer invalidate];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark IBActions
- (IBAction)btnRatingClicked:(id)sender 
{
    NSInteger rating = [(UIButton *)sender tag] - RATING_BUTTON_TAG_BASE + 1;
    
    [self rateVideo:rating];
}

- (IBAction)btnRatingConfirmed:(id)sender 
{
    m_appDataManager.currentPlayerIndex++;
    if ( m_appDataManager.currentPlayerIndex < 3 )
    {
        PlayerViewController *playerController = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
        [self.navigationController pushViewController:playerController animated:YES];
    }
    else 
    {
        ResultViewController *resultController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
        [self.navigationController pushViewController:resultController animated:YES];
    }
}

#pragma mark -
#pragma mark Private Methods
- (void)rateVideo:(NSInteger)rating
{
    for (NSInteger i = 0; i < 5; i++ )
    {
        UIButton *btnRating = (UIButton *)[viewRating viewWithTag:RATING_BUTTON_TAG_BASE + i];
        if ( i < rating )
        {
            btnRating.selected = YES;
        }
        else 
        {
            btnRating.selected = NO;
        }
    }
    
    [m_appDataManager setCurrentPlayerRating:rating];
}

- (void)btnQuitClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)timerFired:(id)sender
{
    m_timeLeft -= TIMER_INTERVAL;
    NSInteger minLeft = m_timeLeft / 60;
    NSInteger secLeft = m_timeLeft % 60;
    self.lblTimer.text = [NSString stringWithFormat:@"%02d:%02d", minLeft, secLeft];
    
    // show condition at time of 12 min - time left == 6
    if ( m_timeLeft == 7 * 60 ) 
    {
        [self showCondition];
    }
    
    // show 'time's up' at time of 15 min - time left == 3
    if ( m_timeLeft == 4 * 60 ) 
    {
        [self showPrepareTimeUp];
    }
    
    if ( m_timeLeft == 1 * 60 )
    {
        [self showOneMinuteLeft];
    }
    
    if ( m_timeLeft == 0 )
    {
        [self stopRecording];
        
        [self.timer invalidate];
    }
}

- (void)showCondition
{
    // get condition
    self.lblCondition.text = [m_appDataManager generateCondition];
    
    self.viewCondition.alpha = 0.0;
    self.viewCondition.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.viewCondition.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.viewCondition.alpha = 0.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.viewCondition.alpha = 1.0;
            }];
        }];
    }];
}

- (void)showPrepareTimeUp
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"3";
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:6];
    label.frame = CGRectMake(self.view.frame.size.width / 2.0 - 30, self.view.frame.size.height / 2.0 - 30, 60, 60);
    [self.view addSubview:label];
    label.alpha = 1.0;
    
    [UIView animateWithDuration:1.0 animations:^{
        label.font = [UIFont systemFontOfSize:60];
        label.alpha = 0.0;
    } completion:^(BOOL finished) 
    {
        label.text = @"2";
        label.font = [UIFont systemFontOfSize:6];
        label.alpha = 1.0;
        [UIView animateWithDuration:1.0 animations:^{
            label.font = [UIFont systemFontOfSize:60];
            label.alpha = 0.0;
        } completion:^(BOOL finished) 
        {
            label.text = @"1";
            label.font = [UIFont systemFontOfSize:6];
            label.alpha = 1.0;
            [UIView animateWithDuration:1.0 animations:^{
                label.font = [UIFont systemFontOfSize:60];
                label.alpha = 0.0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
                [self startRecording];
            }];
        }];
    }];
}

- (void)showOneMinuteLeft
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"时间还剩1分钟";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:24];
    label.frame = CGRectMake(m_videoPicker.view.frame.size.width / 2.0 - 120, m_videoPicker.view.frame.size.height / 2.0 - 30, 240, 60);
    [m_videoPicker.view addSubview:label];
    label.alpha = 0.0;
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationRepeatCount:2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        label.alpha = 0.0;
        [label removeFromSuperview];
    }];
}

- (void)startRecording
{
    m_isPresentingVideoPicker = YES;
    
    m_videoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    m_videoPicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    m_videoPicker.allowsEditing = NO;
    m_videoPicker.showsCameraControls = NO;
    m_videoPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    m_videoPicker.delegate = self;
    
    [m_videoPicker.view addSubview:self.lblTimer];
    [self presentModalViewController:m_videoPicker animated:YES];
    // start capturing video with a 2 seconds delay - for camera to be ready
    [m_videoPicker performSelector:@selector(startVideoCapture) withObject:nil afterDelay:2.0];
}

- (void)stopRecording
{
    [m_videoPicker stopVideoCapture];
}

#pragma mark -
#pragma mark UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ( [mediaType isEqualToString:@"public.movie"] )
    {
        NSLog(@"Selected a video");
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@", [url absoluteString]);
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ( [library videoAtPathIsCompatibleWithSavedPhotosAlbum:url] )
        {
            [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
                if ( !assetURL && error ) 
                {
                    NSLog(@"error saving video to photo album: %@", error.description);
                }
                else 
                {
                    [Utility showAlertWithTitle:@"Video Saved" message:@"Video saved to photo album"];
                    
                    self.btnStart.hidden = YES;
                    [self rateVideo:0];
                    self.viewRating.hidden =  NO;
                }
            }];
        }
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
