//
//  TicketSearchManager.m
//  anywayanyday
//
//  Created by Юлия on 29.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "TicketSearchManager.h"
#import "Airline+Actions.h"

@implementation TicketSearchManager
static id shared = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared = [(TicketSearchManager *) [super alloc] init];
    });
    return shared;
}

-(void)createNewTicketSearchRequest:(TicketSearchOrder*)ticketOrder callback:(void (^)(NSString *requestId, NSError *error))callback{
    NSString* urlString = [NSString stringWithFormat:@"https://www.anywayanyday.com/api2/NewRequest2/?Route=%@%@%@AD%@CN0IN0SC%@&_Serialize=JSON",[self returnCalendarDate:ticketOrder.date],ticketOrder.cityFrom.cityCode, ticketOrder.cityTo.cityCode, ticketOrder.passengersCount,ticketOrder.flightClass];
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [ NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError* error;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (!error) {
                callback(jsonDictionary[@"IdSynonym"],nil);
            }else {
                callback(nil,error);
            }
        }else{
            callback(nil,connectionError);
        }
    }];
    
}

-(void)getRequestState:(NSString*)requestId callback:(void (^)(NSNumber *progressValue, NSError *error))callback{
    NSString* urlString = [NSString stringWithFormat:@"https://www.anywayanyday.com/api2/RequestState/?R=%@&_Serialize=JSON",requestId];
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [ NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError* error;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (!error) {
                callback(jsonDictionary[@"Completed"],nil);
            }else {
                callback(nil,error);
            }
        }else{
            callback(nil,connectionError);
        }
    }];
    
}

-(void)getSearchRequestResult:(NSString*)requestId callback:(void (^)(NSArray *airlines, NSError *error))callback{
    NSString* urlString = [NSString stringWithFormat:@"https://www.anywayanyday.com/api2/Fares2/?L=RU&C=RUB&DebugFullNames=true&_Serialize=JSON&R=%@",requestId];
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [ NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError* error;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (!error) {
                callback([Airline parseAirlinesWithData:jsonDictionary[@"Airlines"]],nil);
            }else {
                callback(nil,error);
            }
        }else{
            callback(nil,connectionError);
        }
    }];
    
}


-(NSString*)returnCalendarDate:(NSDate*)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"ddMM"];
    return  [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate: date]];
}

@end
