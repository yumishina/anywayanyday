//
//  FareListViewController.m
//  anywayanyday
//
//  Created by Юлия on 30.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "FareListViewController.h"
#import "Fare.h"

@interface FareListViewController ()

@end

@implementation FareListViewController

#pragma mark LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"airlineCell"];
    self.tableView.allowsSelection = NO;
    self.navigationItem.title = self.airline.code;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.airline.fares.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"airlineCell"];
    if (self.airline.fares) {
        Fare* fare = [self.airline.fares objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ руб.",fare.price];
    }
    return cell;
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
