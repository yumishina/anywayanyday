//
//  TicketSearchOrder.h
//  anywayanyday
//
//  Created by Юлия on 28.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface TicketSearchOrder : NSObject
@property (strong, nonatomic) City* cityFrom;
@property (strong, nonatomic) City* cityTo;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSNumber *passengersCount;
@property (strong, nonatomic) NSString *flightClass;
@end
