//
//  TicketSearchViewController.h
//  anywayanyday
//
//  Created by Юлия on 26.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "DateViewController.h"

@interface TicketSearchViewController : UIViewController<DateViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *cityFromButton;
@property (strong, nonatomic) IBOutlet UIButton *cityToButton;
@property (strong, nonatomic) IBOutlet UIButton *dateButton;
@property (strong, nonatomic) IBOutlet UILabel *passengersCountLabel;
@property (strong, nonatomic) IBOutlet UIStepper *passengersCountStepper;
@property (strong, nonatomic) IBOutlet UISegmentedControl *classSegment;
@property (strong, nonatomic) IBOutlet UIButton *findTicketButton;
@property (strong, nonatomic) City* cityFrom;
@property (strong, nonatomic) City* cityTo;
@property (strong, nonatomic) NSDate *flightDate;
@property (strong, nonatomic) NSNumber *passengersCount;
@property (strong, nonatomic) NSString *flightClassValue;

- (IBAction)passengersStepperTapped:(id)sender;
- (IBAction)classSegmentTapped:(id)sender;


@end
