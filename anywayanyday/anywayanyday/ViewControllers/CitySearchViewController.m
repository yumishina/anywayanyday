//
//  CitySearchViewController.m
//  anywayanyday
//
//  Created by Юлия on 26.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "CitySearchViewController.h"
#import "TicketSearchViewController.h"
#import "CityCell.h"
#import "City.h"
#import "CitiesManager.h"

@interface CitySearchViewController ()

@end

@implementation CitySearchViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CityCell class] forCellReuseIdentifier:@"cityCell"];
    self.searchBar.delegate = self;
    if (self.isFromCitySearch) {
        self.navigationItem.title = @"Город вылета";
    } else{
        self.navigationItem.title = @"Город прибытия";
    }
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - SearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length >1) {
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        [[CitiesManager sharedInstance] getCitiesWithName:searchText callback:^(NSMutableArray *array, NSError *error) {
            if (!error) {
                self.citiesArray = array;
                [self.tableView reloadData];
                [self.activityIndicator stopAnimating];
                self.viewForIndicator.hidden = YES;
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Произошла ошибка"
                                           message:@"Повторите поиск позже"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil] show];
            }
        }];
    }
}


#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.citiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
    if (self.citiesArray.count>0) {
        City* city = [self.citiesArray objectAtIndex: indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", city.cityName, city.countryName];
        cell.city = city;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityCell *cell = (CityCell *)[tableView cellForRowAtIndexPath: indexPath];
    TicketSearchViewController *tsvc = (TicketSearchViewController*)[self backViewController];
    if (self.isFromCitySearch) {
        tsvc.cityFrom = cell.city;
    }else{
        tsvc.cityTo = cell.city;
    }
    [self.navigationController popToViewController:tsvc animated:YES];
}

- (UIViewController *)backViewController{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
@end
