//
//  WeatherModel.m
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel
+(WeatherModel*)initWithJSON:(NSDictionary *)data{
    WeatherModel *weather = [[self alloc] init];
    weather.cityName = [data valueForKey:@"name"];
    weather.temp = [[data valueForKey:@"main"] valueForKey:@"humidity"];
    weather.weather = [NSString stringWithFormat:@"Weather: %@",[[[data valueForKey:@"weather"]objectAtIndex:0] valueForKey:@"main"]];
    weather.weatherDescription = [NSString stringWithFormat:@"%@",[[[data valueForKey:@"weather"] objectAtIndex:0] valueForKey:@"description"]];
    return weather;
}
@end
