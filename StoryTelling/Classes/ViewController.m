//
//  ViewController.m
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import "ViewController.h"
#import "AboutUsViewController.h"
#import "AppDataManager.h"
#import "PlayerViewController.h"

@interface ViewController ()
{
    AboutUsViewController   *m_aboutUsContoller;
    AppDataManager          *m_appDataManager;
    PlayerViewController    *m_playerViewController;
}

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    m_aboutUsContoller = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    m_appDataManager = [AppDataManager sharedAppDataManager];
    m_playerViewController = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark IBActions
- (IBAction)btnNewGameClicked:(id)sender 
{
    [m_appDataManager generateKeyWords];
    [self.navigationController pushViewController:m_playerViewController animated:YES];
}

- (IBAction)btnAboutUsClicked:(id)sender 
{
    [self.navigationController pushViewController:m_aboutUsContoller animated:YES];
}

@end
