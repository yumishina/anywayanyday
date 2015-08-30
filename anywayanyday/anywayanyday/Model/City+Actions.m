//
//  City+Actions.m
//  anywayanyday
//
//  Created by Юлия on 26.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "City+Actions.h"

@implementation City (Actions)

+(NSMutableArray*)parseCitiesWithData:(NSArray*)data{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (NSDictionary *cityDictionary in data) {
        if (cityDictionary[@"Airport"]== [NSNull null]) {
            City *city = [[City alloc] init];
            city.cityName = cityDictionary[@"City"];
            city.countryName = cityDictionary[@"Country"];
            city.cityCode = cityDictionary [@"CityCode"];
            [resultArray addObject:city];
        }
    }
    return resultArray;
}
@end
