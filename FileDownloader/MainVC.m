//
//  MainVC.m
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import "MainVC.h"
#import "CAPSPageMenu.h"
#import "FileDownloaderVC.h"
#import "WeatherVC.h"
@interface MainVC ()<CAPSPageMenuDelegate>
@property (nonatomic) CAPSPageMenu *pageMenu;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    FileDownloaderVC *fileDownloader = [storyboard instantiateViewControllerWithIdentifier:@"FileDownloaderVC"];
    fileDownloader.title = @"File Downloader";
    
    WeatherVC *weather  = [storyboard instantiateViewControllerWithIdentifier:@"WeatherVC"];
    weather.title = @"Weather";
    
    
    NSArray *controllerArray  = @[fileDownloader,weather];;
    NSDictionary *parameters;
    
        parameters = @{
                       CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor clearColor],CAPSPageMenuOptionMenuItemSeparatorWidth: @(1.0),
                       CAPSPageMenuOptionMenuItemSeparatorColor: [UIColor colorWithRed:152.0/255.0f green:167.0/255.0f blue:180.0/255.0f alpha:1.0],
                       CAPSPageMenuOptionViewBackgroundColor: [UIColor clearColor],
                       CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:5.0/255.0f green:102.0/255.0f blue:159.0/255.0f alpha:1.0],
                       CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor clearColor],
                       CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.3],
                       CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6],
                       CAPSPageMenuOptionMenuItemFont: [UIFont boldSystemFontOfSize:15.0],
                       CAPSPageMenuOptionMenuHeight: @(49.0),
                       
                       CAPSPageMenuOptionMenuItemWidth: @(self.view.frame.size.width/2 - 25),
                       CAPSPageMenuOptionCenterMenuItems: @(YES)
                       };
    
    
    
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0, 72.0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height) options:parameters withType:NO];
    _pageMenu.delegate = self;
    [self.view addSubview:_pageMenu.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
