//
//  WeatherVC.m
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import "WeatherVC.h"
#import "WeatherCell.h"
#import "WeatherModel.h"
#import "APIManager.h"
@interface WeatherVC ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) IBOutlet UITextField *cityTxtF;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation WeatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _indicatorView.hidden = YES;
    _dataArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}
-(IBAction)searchForWeather:(id)sender{
    if (_cityTxtF.text.length > 0) {
        _indicatorView.hidden = NO;
        [self.indicatorView startAnimating];
        [[APIManager sharedInstance] getDataFromUrl:_cityTxtF.text withCallBack:^(BOOL isSuccess, NSDictionary *dict, NSError *error) {
            [self.indicatorView stopAnimating];
            _indicatorView.hidden = YES;
            _cityTxtF.text = @"";
            if (isSuccess) {
                if (_dataArray.count > 0) {
                    [_dataArray removeAllObjects];
                }
                WeatherModel *model = [WeatherModel initWithJSON:dict];
                [_dataArray addObject:model];
                [self.tableView reloadData];
                
            }else{
                [self showAlert:@"Downloading failed" withTitle:@"Failed"];
            }
        }];
    
    }else{
        [self showAlert:@"Please enter the city" withTitle:@"Error"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"WeatherCell";
    WeatherCell   *Cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (Cell != nil) {
        
        [Cell setData:[_dataArray objectAtIndex:0]];
    }
    [Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return Cell;
    
}
-(void)showAlert:(NSString *)description withTitle:(NSString *)title{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:description
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    
    
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
