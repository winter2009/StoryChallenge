//
//  ResultViewController.m
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import "ResultViewController.h"
#import "AppDataManager.h"

@interface ResultViewController ()
{
    AppDataManager  *m_appDataManager;
}

@end

@implementation ResultViewController
@synthesize lblResult;

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
    self.navigationController.navigationBarHidden = YES;
    
    m_appDataManager = [AppDataManager sharedAppDataManager];
    self.lblResult.text = [NSString stringWithFormat:@"%@ 是大赢家", [m_appDataManager winner]];
}

- (void)viewDidUnload
{
    [self setLblResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark IBActions
- (IBAction)btnOKClicked:(id)sender 
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
