//
//  APIManager.h
//  FileDownloader
//
//  Created by user on 04/04/18.
//  Copyright © 2018 SagarGupta. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol APIManagerDelegate <NSObject>
-(void)updateDownloadProgress:(float)value;
@end
@interface APIManager : NSObject
@property (nonatomic, assign) id <APIManagerDelegate> delegate;
+ (instancetype)sharedInstance;
-(void)downloadFileFromTheUrl:(NSString *)url  withCallBack:(void (^)(BOOL isSuccess, NSURL  *filePath, NSError *error))callBack;
@end


