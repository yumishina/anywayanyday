//
//  DateViewController.m
//  anywayanyday
//
//  Created by Юлия on 28.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController

#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:1];
    [comps setDay:-1];
    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    self.datePicker.minimumDate = currentDate;
    self.datePicker.maximumDate = maxDate;
    self.navigationItem.title = @"Дата вылета";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
- (IBAction)choseButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(choseDate:)]) {
        [self.delegate choseDate: [self.datePicker date]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
