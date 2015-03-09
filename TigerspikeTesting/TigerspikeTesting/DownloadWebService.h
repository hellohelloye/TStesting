//
//  DownloadWebService.h
//  TigerspikeTesting
//
//  Created by yye on 3/9/15.
//  Copyright (c) 2015 Yukui Ye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSModel.h"

@interface DownloadWebService : NSObject<NSURLConnectionDataDelegate>
@property (nonatomic, strong) TSModel *tsmodel;
@property (nonatomic, strong) NSArray *tsArray;
-(void)getJsonDataFromInternet;
-(NSArray *)JSONKeyPathsByPropertyKey:(NSDictionary *) dic;
@end
