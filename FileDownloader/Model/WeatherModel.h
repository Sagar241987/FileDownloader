//
//  WeatherModel.h
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *temp;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *weatherDescription;
+(WeatherModel*)initWithJSON:(NSDictionary *)data;
@end
