//
//  PlayerViewController.m
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import "PlayerViewController.h"
#import "AppDataManager.h"
#import "Utility.h"
#import "VideoRecordViewController.h"

@interface PlayerViewController ()
{
    AppDataManager      *m_appDataManager;
}

- (void)btnQuitClicked:(id)sender;

@end

@implementation PlayerViewController
@synthesize lblKeywords;
@synthesize txtName;

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
}

- (void)viewDidUnload
{
    [self setTxtName:nil];
    [self setLblKeywords:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [NSString stringWithFormat:@"玩家 %d", m_appDataManager.currentPlayerIndex + 1];
    
    self.lblKeywords.text = [m_appDataManager keywordsString];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark IBActions
- (IBAction)btnOKClicked:(id)sender 
{
    if ( [self.txtName.text length] > 0 )
    {
        [m_appDataManager setCurrentPlayerName:self.txtName.text];
        VideoRecordViewController *videoController = [[VideoRecordViewController alloc] initWithNibName:@"VideoRecordViewController" bundle:nil];
        [self.navigationController pushViewController:videoController animated:YES];
    }
    else 
    {
        [Utility showAlertWithTitle:@"Name" message:@"Please fill in your nick name"];
    }
}

#pragma mark -
#pragma mark Private Methods
- (void)btnQuitClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

@end
