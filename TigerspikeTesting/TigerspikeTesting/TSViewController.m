//
//  TSViewController.m
//  TigerspikeTesting
//
//  Created by yye on 3/9/15.
//  Copyright (c) 2015 Yukui Ye. All rights reserved.
//

#import "TSViewController.h"

@interface TSViewController ()

@property (nonatomic, strong) NSArray *tsArray;

@end

@implementation TSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [downloadBtn setTitle:@"Get Data" forState:UIControlStateNormal];
    UIButton *deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(110, 0, 100 ,40)];
    [deleteBtn setTitle:@"Delete Item" forState:UIControlStateNormal];

    [downloadBtn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn addTarget:self action:@selector(deleteItem) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:downloadBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
}

- (void)getData {
    if (self.dws == nil) {
        self.dws = [[DownloadWebService alloc] init];
    }
    self.tsArray = [self.dws getJsonDataFromInternet];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector: @selector(doSomething)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)doSomething {
    if (self.tsArray != nil) {
        [self.tableView reloadData];
    }
}

- (void)deleteItem {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSCustomTVC *tsCustomTVC = [tableView dequeueReusableCellWithIdentifier:@"customerTVC" forIndexPath:indexPath];
    TSModel *tsmodel = self.tsArray[indexPath.row];
    
    tsCustomTVC.nameLabel.text = tsmodel.name;
    [tsCustomTVC.iconImageBtn setBackgroundImage:[UIImage imageNamed:tsmodel.iconImage] forState:UIControlStateNormal];
    
    tsCustomTVC.backgroundColor = [UIColor clearColor];
    return tsCustomTVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
