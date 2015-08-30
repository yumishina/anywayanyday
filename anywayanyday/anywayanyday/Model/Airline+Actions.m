//
//  Airline+Actions.m
//  anywayanyday
//
//  Created by Юлия on 30.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "Airline+Actions.h"
#import "Fare+Actions.h"

@implementation Airline (Actions)

+(NSMutableArray*)parseAirlinesWithData:(NSArray*)data{
    NSMutableArray* resultArray = [NSMutableArray new];
    for (NSDictionary* parseDictionary in data) {
        Airline* airline = [Airline new];
        airline.code  = parseDictionary[@"Code"];
        airline.fares = [Fare parseFaresWithData:parseDictionary[@"Fares"]];
        airline.minFare = [Airline returnMinValue: airline.fares];
        [resultArray addObject: airline];
    }
    
    return resultArray;
}

+(Fare*)returnMinValue:(NSArray*)array{
    Fare* minFare = [array objectAtIndex:0];
    for (Fare* currentFare in array) {
        if ([minFare.price intValue] > [currentFare.price intValue]) {
            minFare = currentFare;
        }
    }
    return minFare;
}

@end
