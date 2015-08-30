//
//  TicketResultsViewController.m
//  anywayanyday
//
//  Created by Юлия on 29.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "TicketResultsViewController.h"
#import "TicketSearchManager.h"
#import "FareListViewController.h"
#import "AirlineCell.h"

@interface TicketResultsViewController (){
    NSTimer* repeatTimer;
}

@end

@implementation TicketResultsViewController

#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewForProgressView.hidden = NO;
    [self.tableView registerClass:[AirlineCell class] forCellReuseIdentifier:@"airlineCell"];
    self.navigationItem.title = @"Результаты поиска";
    [[TicketSearchManager sharedInstance] createNewTicketSearchRequest:self.ticketOrder callback:^(NSString *requestId, NSError *error) {
        if (!error) {
            self.requestId = requestId;
            repeatTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                           target:self
                                                         selector:@selector(getRequestState:)
                                                         userInfo:nil
                                                          repeats:YES];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Произошла ошибка"
                                        message:@"Повторите поиск позже"
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Server calls
-(void)getRequestState:(NSTimer*)timer{
    [[TicketSearchManager sharedInstance] getRequestState:self.requestId callback:^(NSNumber *progressValue, NSError *error) {
        if (!error) {
            if ([progressValue intValue] == 100) {
                [repeatTimer invalidate];
                repeatTimer = nil;
                [self fetchRequestResult];
            }
            self.progressView.progress = [progressValue floatValue]/100;
        }else{
            [repeatTimer invalidate];
            repeatTimer = nil;
            [[[UIAlertView alloc] initWithTitle:@"Произошла ошибка"
                                        message:@"Повторите поиск позже"
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }];
}

-(void)fetchRequestResult{
    [[TicketSearchManager sharedInstance] getSearchRequestResult:self.requestId callback:^(NSArray *airlines, NSError *error) {
        if (!error) {
            if (airlines.count>0) {
                self.airlinesArray = airlines;
                [self.tableView reloadData];
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Поиск не дал результатов"
                                            message:@"Измените параметры поиска"
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
            }
            self.viewForProgressView.hidden = YES;
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Произошла ошибка"
                                        message:@"Повторите поиск позже"
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }];
}

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.airlinesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AirlineCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"airlineCell"];
    if (self.airlinesArray.count) {
        cell.airline = [self.airlinesArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",cell.airline.code, cell.airline.minFare.price];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AirlineCell *cell = (AirlineCell *)[tableView cellForRowAtIndexPath: indexPath];
    self.airline = cell.airline;
    [self performSegueWithIdentifier: @"fareList" sender: [tableView cellForRowAtIndexPath: indexPath]];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"fareList"])
    {
        FareListViewController *fareListViewController = [segue destinationViewController];
        if (self.airline) {
            fareListViewController.airline = self.airline;
        }
    }
}


@end
