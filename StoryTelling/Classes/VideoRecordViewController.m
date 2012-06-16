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

@interface VideoRecordViewController ()
{
    AppDataManager  *m_appDataManager;
    UIImagePickerController *m_videoPicker;
}

- (void)rateVideo:(NSInteger)rating;
- (void)btnQuitClicked:(id)sender;

@end

@implementation VideoRecordViewController
@synthesize lblKeywords;
@synthesize btnStart;
@synthesize viewRating;

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
}

- (void)viewDidUnload
{
    [self setBtnStart:nil];
    [self setViewRating:nil];
    [self setLblKeywords:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [m_appDataManager currentPlayerName];
    
    self.lblKeywords.text = [m_appDataManager keywordsString];
    self.btnStart.hidden = NO;
    self.viewRating.hidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark IBActions
- (IBAction)btnStartRecordClicked:(id)sender 
{
    m_videoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    m_videoPicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    m_videoPicker.allowsEditing = NO;
    m_videoPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    m_videoPicker.delegate = self;
    
    [self presentModalViewController:m_videoPicker animated:YES];
    self.btnStart.hidden = YES;
}

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
