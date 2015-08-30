//
//  TicketSearchManager.h
//  anywayanyday
//
//  Created by Юлия on 29.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketSearchOrder.h"

@interface TicketSearchManager : NSObject

+ (instancetype)sharedInstance;
-(void)createNewTicketSearchRequest:(TicketSearchOrder*)ticketOrder callback:(void (^)(NSString *requestId, NSError *error))callback;
-(void)getRequestState:(NSString*)requestId callback:(void (^)(NSNumber *progressValue, NSError *error))callback;
-(void)getSearchRequestResult:(NSString*)requestId callback:(void (^)(NSArray *airlines, NSError *error))callback;
@end
