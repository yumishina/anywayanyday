//
//  Airline.h
//  anywayanyday
//
//  Created by Юлия on 29.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fare.h"

@interface Airline : NSObject
@property(strong, nonatomic) NSString *code;
@property(strong, nonatomic) NSMutableArray *fares;
@property(strong, nonatomic) Fare *minFare;
@end
