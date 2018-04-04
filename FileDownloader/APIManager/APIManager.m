//
//  APIManager.m
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
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
@end
