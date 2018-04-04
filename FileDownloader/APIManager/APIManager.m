//
//  APIManager.m
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#define API_PATH @"http://api.openweathermap.org/data/2.5/weather?q="
#define API_KEY @"54538b4b399b212a77523788f37bdf0a"
@implementation APIManager
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)downloadFileFromTheUrl:(NSString *)url  withCallBack:(void (^)(BOOL isSuccess, NSURL  *filePath, NSError *error))callBack{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view
            [_delegate updateDownloadProgress:downloadProgress.fractionCompleted];
            
        });
        
        
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        NSInteger statusCode = [HTTPResponse statusCode];
        

        if (statusCode == 200) {
            // Do operation after download is complete
            //Success
            callBack(true, filePath , nil);
            
        }else{
            //Failure
            callBack(false, nil , nil);
        }
        
        
    }];
    [downloadTask resume];
}
-(void)getDataFromUrl:(NSString *)cityName withCallBack:(void (^)(BOOL isSuccess, NSDictionary *response, NSError *error))callBack{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@&appid=%@",API_PATH,cityName,API_KEY] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            callBack(true, responseObject , nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
