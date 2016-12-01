//
//  ViewController.m
//  collectionViewLineLayoutDemo
//
//  Created by 康世朋 on 2016/12/1.
//  Copyright © 2016年 康世朋. All rights reserved.
//

#import "ViewController.h"
#import "ChosenTableViewCell.h"
#import "Model.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [_dataSource addObject:[[Model alloc]init]];
    }
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_table registerNib:[UINib nibWithNibName:@"ChosenTableViewCell" bundle:nil] forCellReuseIdentifier:@"tablecell"];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 290;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChosenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecell"];
    cell.dataSource = _dataSource;
    [cell didSelectAtIndexPath:^(NSIndexPath *indexPath) {
        NSLog(@"点击了第%ld",(long)indexPath.row);
    }];
    [cell didClickAllButton:^{
        NSLog(@"点击了all");
    }];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
