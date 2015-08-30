//
//  CitySearchViewController.h
//  anywayanyday
//
//  Created by Юлия on 26.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite) BOOL isFromCitySearch;
@property (strong, nonatomic) NSMutableArray *citiesArray;
@property (strong, nonatomic) IBOutlet UIView *viewForIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
