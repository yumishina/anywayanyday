//
//  CitiesManager.m
//  anywayanyday
//
//  Created by Юлия on 26.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import "CitiesManager.h"
#import "City+Actions.h"

@implementation CitiesManager
static id shared = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared = [(CitiesManager *) [super alloc] init];
    });
    return shared;
}


-(void)getCitiesWithName:(NSString*)text callback:(void (^)(NSMutableArray *array, NSError *error))callback {
    NSString* encodedText = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* urlString = [NSString stringWithFormat:@"https://www.anywayanyday.com/AirportNames/?language=RU&filter=%@&_Serialize=JSON",encodedText];
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [ NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSError* error;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (!error) {
                callback([City parseCitiesWithData:jsonDictionary[@"Array"]],nil);
            }else {
                callback(nil,error);
            }
        }else{
            callback(nil,connectionError);
        }
    }];
}
@end
