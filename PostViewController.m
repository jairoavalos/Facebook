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
@property (weak, nonatomic) IBOutlet UIImageView *tabBar;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)onLikeButtonPressed:(id)sender;

@end

@implementation PostViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
    // Configure the nav bar
    self.navigationItem.title = @"Post";
  
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-button"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = backButton;

    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share-icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = shareButton;
  
    // Set up container view style
    self.postContainer.layer.cornerRadius = 2;
    self.postContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    self.postContainer.layer.shadowOffset = CGSizeMake(0, 1);
    self.postContainer.layer.shadowOpacity = .15;
    self.postContainer.layer.shadowRadius = 1;
    
    // Set up Attributed Label
    CGRect labelFrame = CGRectMake(10, 52, 280, 75);
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:labelFrame];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor darkGrayColor];
    label.numberOfLines = 4;
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
    //label.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    
    NSString *text = @"From collarless shirts to high-waisted pants, #Her's costume designer, Casey Storm, explains how he created his fashion looks for the future: http://bit.ly/1jV9zM8";
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"#Her's" options:NSCaseInsensitiveSearch];
        NSRange linkRange = [[mutableAttributedString string] rangeOfString:@"http://bit.ly/1jV9zM8" options:NSCaseInsensitiveSearch];
        
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            //[mutableAttributedString addAttribute:kTTTStrikeOutAttributeName value:[NSNumber numberWithBool:YES] range:linkRange];
            [label addLinkToURL:[NSURL URLWithString:@"http://bit.ly/1jV9zM8"] withRange:linkRange]; // Embedding a custom link in a substring
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    [self.postContainer addSubview:label];
    
    
    // Text field style
    self.commentField.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
            
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
            
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                                  delay:0.0
                                options:(animationCurve << 16)
                             animations:^{
                                 self.commentField.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentField.frame.size.height, self.commentField.frame.size.width, self.commentField.frame.size.height);
                             }
                             completion:nil];
}
        
- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
            
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
            
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                                  delay:0.0
                                options:(animationCurve << 16)
                             animations:^{
                                 self.commentField.frame = CGRectMake(0, self.view.frame.size.height - self.commentField.frame.size.height - self.tabBar.frame.size.height, self.commentField.frame.size.width, self.commentField.frame.size.height);
                             }
                             completion:nil];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onLikeButtonPressed:(id)sender {
    if (self.likeButton.selected) {
        [self.likeButton setSelected:NO];
    } else {
        [self.likeButton setSelected:YES];
    }
}
        


@end
