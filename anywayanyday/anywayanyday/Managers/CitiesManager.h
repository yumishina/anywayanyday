//
//  CitiesManager.h
//  anywayanyday
//
//  Created by Юлия on 26.07.15.
//  Copyright (c) 2015 yulia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesManager : NSObject

+ (instancetype)sharedInstance;
-(void)getCitiesWithName:(NSString*)text callback:(void (^)(NSMutableArray *array, NSError *error))callback;
@end
