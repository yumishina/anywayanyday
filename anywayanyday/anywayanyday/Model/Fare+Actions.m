//
//  Fare+Actions.m
//  anywayanyday
//
//  Created by Юлия on 30.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "Fare+Actions.h"


@implementation Fare (Actions)

+(NSMutableArray*)parseFaresWithData:(NSArray*)data{
    NSMutableArray* resultArray = [NSMutableArray new];
    for (NSDictionary* parseDictionary in data) {
        Fare *fare = [Fare new];
        fare.price = parseDictionary[@"TotalAmount"];
        [ resultArray addObject: fare];
    }
    return resultArray;
}

@end
