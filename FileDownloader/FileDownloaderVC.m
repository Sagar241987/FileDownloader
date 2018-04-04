//
//  ViewController.m
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import "FileDownloaderVC.h"
#import "APIManager.h"
@interface FileDownloaderVC () <APIManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *downloadPercantageLabel;
@end

@implementation FileDownloaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgView.layer.borderWidth = 1.0;
    _imgView.layer.borderColor = [UIColor grayColor].CGColor;
    _imgView.clipsToBounds = YES;
    _urlTextField.text = @"https://cdn.gratisography.com/photos/445H.jpg";
    [APIManager sharedInstance].delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}
// Start downloading after clicking on download button
- (IBAction)downloadResponder:(id)sender {
    if (_urlTextField.text.length > 0) {
        [[APIManager sharedInstance] downloadFileFromTheUrl:_urlTextField.text withCallBack:^(BOOL isSuccess, NSURL *url, NSError *error) {
            
            if (isSuccess) {
                
                [self showAlert:@"Download Completed" withTitle:@"Success"];
                [self displayImage:url];
                
            }else{
                [self showAlert:@"Downloading failed" withTitle:@"Failed"];
            }
        }];
    }else{
        [self showAlert:@"Please provide the url to download" withTitle:@"Error"];
    }
}
-(void)displayImage:(NSURL *)url{
    //Image display after downloading
    NSString *imageUrl = url.absoluteString;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullImgNm=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithString:[imageUrl lastPathComponent]]];
    [_imgView setImage:[UIImage imageWithContentsOfFile:fullImgNm]];
}

-(void)updateDownloadProgress:(float)value{
    
    _progressBar.progress = value;
    _downloadPercantageLabel.text = [NSString stringWithFormat:@"%.0f%@",value*100,@"%"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
