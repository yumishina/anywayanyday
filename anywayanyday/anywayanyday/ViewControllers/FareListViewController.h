//
//  FareListViewController.h
//  anywayanyday
//
//  Created by Юлия on 30.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Airline.h"

@interface FareListViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Airline* airline;
@end
