//
//  TSViewController.h
//  TigerspikeTesting
//
//  Created by yye on 3/9/15.
//  Copyright (c) 2015 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
