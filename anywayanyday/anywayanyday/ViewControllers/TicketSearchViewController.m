//
//  TicketSearchViewController.m
//  anywayanyday
//
//  Created by Юлия on 26.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "TicketSearchViewController.h"
#import "CitySearchViewController.h"
#import "TicketResultsViewController.h"


@interface TicketSearchViewController ()
@end


@implementation TicketSearchViewController


#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.findTicketButton.userInteractionEnabled  = NO;
    self.findTicketButton.alpha  =0.3;
    self.flightClassValue = @"E";
    self.passengersCount = @1;
    self.navigationItem.title = @"Параметры поиска";
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.cityFrom!=nil) {
        [self.cityFromButton setTitle: self.cityFrom.cityName forState:UIControlStateNormal];
    }else{
        [self.cityFromButton setTitle:@"Выберите город" forState:UIControlStateNormal];
    }
    if (self.cityTo!=nil) {
        [self.cityToButton setTitle: self.cityTo.cityName forState:UIControlStateNormal];
    }else{
        [self.cityToButton setTitle:@"Выберите город" forState:UIControlStateNormal];
    }
    if (self.flightDate!=nil) {
        [self.dateButton setTitle:[self getChosenDate:self.flightDate] forState:UIControlStateNormal];
    }else{
        [self.dateButton setTitle:@"Выберите дату" forState:UIControlStateNormal];
    }
    if (self.cityFrom!=nil && self.cityTo!=nil) {
        if (![self.cityFrom.cityCode isEqualToString:self.cityTo.cityCode]) {
            [self.cityFromButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.cityToButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            if ( self.flightDate!=nil) {
                self.findTicketButton.userInteractionEnabled  = YES;
                self.findTicketButton.alpha  = 1;
            }
        }else{
            [self.cityFromButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.cityToButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"cityFromSegue"])
    {
        CitySearchViewController *csvc = [segue destinationViewController];
        csvc.isFromCitySearch = YES;
    } else if ([[segue identifier] isEqualToString:@"cityToSegue"]){
        CitySearchViewController *csvc = [segue destinationViewController];
        csvc.isFromCitySearch = NO;
    }else if ([[segue identifier] isEqualToString:@"dateViewController"]){
        DateViewController *dvc =[segue destinationViewController];
        dvc.delegate = self;
    }else if ([[segue identifier] isEqualToString:@"ticketResultsViewController"]){
        TicketResultsViewController *trvc =[segue destinationViewController];
        trvc.ticketOrder = [self returnTicketOrder];
    }
}

-(TicketSearchOrder*)returnTicketOrder{
    TicketSearchOrder* ticketOrder = [TicketSearchOrder new];
    ticketOrder.cityFrom = self.cityFrom;
    ticketOrder.cityTo = self.cityTo;
    ticketOrder.date = self.flightDate;
    ticketOrder.passengersCount = self.passengersCount;
    ticketOrder.flightClass = self.flightClassValue;
    return ticketOrder;
}

#pragma  mark DateViewControllerDelegate
-(void)choseDate:(NSDate *)date{
    self.flightDate = date;
}

-(NSString*)getChosenDate:(NSDate*)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    return  [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate: date]];
}

#pragma  mark Actions

- (IBAction)passengersStepperTapped:(id)sender {
    self.passengersCountLabel.text = [NSString stringWithFormat:@"Число пассажиров: %@",[NSString stringWithFormat:@"%.f",self.passengersCountStepper.value]];
    self.passengersCount = [NSNumber numberWithDouble:self.passengersCountStepper.value];
}

- (IBAction)classSegmentTapped:(id)sender {
    if (self.classSegment.selectedSegmentIndex == 0) {
        self.flightClassValue = @"E";
    }else{
        self.flightClassValue = @"B";
    }
}
@end
