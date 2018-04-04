//
//  WeatherCell.m
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import "WeatherCell.h"
#import "WeatherModel.h"
@interface WeatherCell ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempratureLabel;

@end
@implementation WeatherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(WeatherModel *)model{
    _cityNameLabel.text = model.cityName;
    _tempratureLabel.text = [NSString stringWithFormat:@"%@°",model.temp];
    _weatherLabel.text = model.weather;
    _descriptionLabel.text = model.weatherDescription;
}
@end
