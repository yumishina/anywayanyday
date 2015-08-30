//
//  TicketResultsViewController.h
//  anywayanyday
//
//  Created by Юлия on 29.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketSearchOrder.h"
#import "Airline.h"

@interface TicketResultsViewController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIView *viewForProgressView;
@property (strong, nonatomic) TicketSearchOrder *ticketOrder;
@property (strong, nonatomic) NSString *requestId;
@property (strong, nonatomic) NSArray* airlinesArray;
@property (strong, nonatomic) Airline* airline;

@end
