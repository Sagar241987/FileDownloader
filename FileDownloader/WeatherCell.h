//
//  WeatherCell.h
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherModel.h"
@interface WeatherCell : UITableViewCell
-(void)setData:(WeatherModel *)model;
@end
