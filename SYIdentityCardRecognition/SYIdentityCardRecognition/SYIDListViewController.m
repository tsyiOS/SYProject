//
//  SYIDListViewController.m
//  SYIdentityCardRecognition
//
//  Created by leju_esf on 17/1/6.
//  Copyright © 2017年 tsy. All rights reserved.
//

#import "SYIDListViewController.h"
#import "SYIDCell.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface SYIDListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SYIDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SYIDCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SYIDCell class])];
    self.title = @"列表";
    self.tableView.rowHeight = ScreenW/300 * 190;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SYIDCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SYIDCell class])];
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray *)datas {
    if (_datas == nil) {
        _datas = [SYIdentityModel sy_getSYIdentityModelDataFormArchive];
    }
    return _datas;
}

@end
