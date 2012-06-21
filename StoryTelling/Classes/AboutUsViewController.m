//
//  AboutUsViewController.m
//  StoryTelling
//
//  Created by Zonghui Zhang on 16/6/12.
//  Copyright (c) 2012 PhoneSoul. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
@synthesize txtInfo;

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
    self.title = @"关于";
    
    self.txtInfo.text = @"没有剧本，天马行空 – 你敢不敢来让你的想象力起飞？ \n现场创作，即兴表演 – 你敢不敢来见识这独特的比赛？ \n实践剧场下的挑战书，你敢不敢来？ \n\n“故事擂台”是一项实践剧场首创，别具一格的华语和英语讲故事比赛。自 2007 年举办以来，吸引了全岛各中小学的积极回响，在过去的 5 年里，一届比一届成功！ \n\n还在犹豫什么呢？大胆尝试吧！“故事擂台”开放给所有小学及中学生。不分国籍、种族、年龄、性别。我们欢迎你来挑战！  \n\n\n\nwww.practice.org.sg\nhttp://blog.omy.sg/ttp ";
}

- (void)viewDidUnload
{
    [self setTxtInfo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
