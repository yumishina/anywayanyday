//
//  DateViewController.h
//  anywayanyday
//
//  Created by Юлия on 28.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateViewControllerDelegate <NSObject>

-(void)choseDate:(NSDate*)date;

@end

@interface DateViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) id <DateViewControllerDelegate> delegate;


@end
