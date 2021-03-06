//
//  DownloadWebService.m
//  TigerspikeTesting
//
//  Created by yye on 3/9/15.
//  Copyright (c) 2015 Yukui Ye. All rights reserved.
//

#import "DownloadWebService.h"

@implementation DownloadWebService
- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSArray *)getJsonDataFromInternet {
    //https://api.myjson.com/bins/2ukm9
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.myjson.com/bins/2ukm9"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data) {
            NSLog(@"%s: sendAynchronousRequest error: %@", __FUNCTION__, connectionError);
            return;
        } else if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode != 200) {
                NSLog(@"%s: sendAsynchronousRequest status code != 200: response = %@", __FUNCTION__, response);
                
                return;
            }
        }
        
        NSError *parseError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (!dictionary) {
            NSLog(@"%s: JSONObjectWithData error: %@; data = %@", __FUNCTION__, parseError, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            return;
        }
        // now you can use your `dictionary` object
        NSLog(@"all values %@: ",[dictionary allValues]);
        self.tsArray = [self JSONKeyPathsByPropertyKey: dictionary];
    }];
    return self.tsArray;
}

- (NSArray *)JSONKeyPathsByPropertyKey:(NSDictionary *)dic {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSDictionary *helperArray = [[NSDictionary alloc] init];
    helperArray = [[dic allValues] firstObject] ;
    for (NSDictionary *item in helperArray) {
        TSModel * tsmodel = [[TSModel alloc] init];
        tsmodel.name = [item objectForKey:@"name"];
        tsmodel.url = [item objectForKey:@"url"];
        tsmodel.iconImage =[self getIconImg:[item objectForKey:@"icon"]];
        
        [result addObject:tsmodel];
    }
    
    self.tsmodel = [result copy];
    return self.tsArray;
}

- (NSString *)getIconImg:(NSString *)iconImgUrl {
    NSRange startRange = [iconImgUrl rangeOfString:@"assets/"];
    
    NSRange searchRange = NSMakeRange(startRange.location + startRange.length, iconImgUrl.length - startRange.length - startRange.location);
    return [NSString stringWithString :[iconImgUrl substringWithRange:searchRange]];
}

@end
