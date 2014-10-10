//
//  SKScoreViewController.m
//  Score Keeper
//
//  Created by Joseph Aranda on 9/24/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "SKScoreViewController.h"

static CGFloat margin = 20;
static CGFloat scoreViewHeight = 90;


@interface SKScoreViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray * scoreLabel;

@end

@implementation SKScoreViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

 self.title = @"Score Keeper";
    
    self.scoreLabel = [[NSMutableArray alloc] init];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width - 64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    for (NSInteger i = 0; i < 4; i++) {
        [self addScoreView:i];

  }
}
    - (void) addScoreView:(NSInteger)index {
    
        CGFloat nameFieldWidth = 90;
        CGFloat scoreFieldWidth = 60;
        CGFloat stepperButtonWidth = 90;
        
        CGFloat width = self.view.frame.size.width;
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, index * scoreViewHeight, width, scoreViewHeight)];
        
        UITextField * nameField = [[UITextField alloc]initWithFrame:CGRectMake(margin, margin, nameFieldWidth, 44)];
        nameField.tag = -1000;
        nameField.delegate = self;
        nameField.placeholder = @"Name";
        [view addSubview:nameField];
     
        // We need to store the index we're adding as the tag of the text field so that we can find the corresponding button when the text changes
        UILabel * scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(margin+ nameFieldWidth, margin, scoreFieldWidth, 44)];
        scoreLable.text = @"0";
        scoreLable.textAlignment = NSTextAlignmentCenter;
        [self.scoreLabel addObject:scoreLable];
        [view addSubview:scoreLable];
        
        // We need to store the index we're adding as the tag of the button so we can find the corresponding text when the user taps the button
        UIStepper * scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(60 + nameFieldWidth + scoreFieldWidth, 30, stepperButtonWidth, 44)];
        scoreStepper.maximumValue = 1000;
        scoreStepper.maximumValue = -1000;
        scoreStepper.tag = index;
        
        [scoreStepper addTarget:self action:@selector(scoreStepperChanged:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:scoreStepper];

        UIView * seperator = [[UIView alloc] initWithFrame:CGRectMake(0, scoreViewHeight -2, self.view.frame.size.width, 1)];
        seperator.backgroundColor = [UIColor lightGrayColor];
        [self.scrollView addSubview:view];
    }

- (void)scoreStepperChanged:(id)sender {
    UIStepper * stepper = sender;
    NSInteger index =stepper.tag;
    double value = [stepper value];
    
    UILabel * scorelabel = self.scoreLabel[index];
    scorelabel.text = [NSString stringWithFormat:@"%d", (int)value];
    
}

- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}


@end

