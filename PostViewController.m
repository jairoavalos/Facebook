//
//  PostViewController.m
//  Facebook
//
//  Created by Jairo Avalos on 6/5/14.
//  Copyright (c) 2014 Jairo Avalos. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
@property (strong, nonatomic) IBOutlet UIView *postContainer;
@property (strong, nonatomic) IBOutlet UITextField *commentField;

@end

@implementation PostViewController

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
    // Do any additional setup after loading the view from its nib.
  
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
  // Configure the title
  self.navigationItem.title = @"Post";
  
  self.postContainer.layer.cornerRadius = 2;
  self.postContainer.layer.shadowColor = [UIColor blackColor].CGColor;
  self.postContainer.layer.shadowOffset = CGSizeMake(0, 1);
  self.postContainer.layer.shadowOpacity = .15;
  self.postContainer.layer.shadowRadius = 1;
  
  self.commentField.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
  
  UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
  self.navigationItem.backBarButtonItem = backButton;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
