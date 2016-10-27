//
//  RTHEditinformationController.m
//  儒思HR
//
//  Created by yjc on 16/10/27.
//  Copyright © 2016年 Yala. All rights reserved.
//

#import "RTHEditinformationController.h"
#import "RTHEditinformationCell.h"
#import "RTHEditInformationFooterView.h"
#import <SYImageManager/SYImageManager.h>

@interface RTHEditinformationController ()<UITableViewDelegate,UITableViewDataSource,SYImagePickerDelegate>
@property (nonatomic ,strong)NSArray *titleArray;
@property (nonatomic ,strong)NSArray *detitieArray;
@property (nonatomic, strong) RTHEditInformationFooterView *footer;
@end
@implementation RTHEditinformationController
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[RTHEditinformationCell class] forCellReuseIdentifier:@"RTHEditinformation"];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self. tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = self.footer;
}

- (void)openAlbum {
    [SYImageManager shareImageManager].delegate = self;
    [[SYImageManager shareImageManager] sy_OpenImagePicker];
}

- (void)sy_didFinishedPickingMediaWithInfo:(NSDictionary *)info {
    NSArray *images = info[SYSelectedImages];
    CGFloat height = [self.footer.displayView dispalyImages:images];
    self.footer.sy_height = height + 85;
    self.footer.tipLabel.hidden = images.count > 0;
}

#pragma mark-UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   RTHEditinformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTHEditinformation"forIndexPath:indexPath];
     cell.leftLabel.text  = self.titleArray[indexPath.section];
    cell.rightLabel.text = self.detitieArray[indexPath.section];
    //cell.textLabel.text = [NSString stringWithFormat:@"测试数据－－－%zd",indexPath.row ];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    return [UIView new];
}
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"真实姓名",
                        @"所在城市",
                        @"公司名称",
                        @"头衔／职位",
                        @"擅长领域"
                        ];
    }
    return _titleArray;
}
- (NSArray *)detitieArray {
    if (!_detitieArray) {
        _detitieArray = [NSArray array];
        _detitieArray = @[@"请输入你的姓名",
                          @"请选择你所在的城市",
                          @"请输入你公司名称",
                          @"请输入你的职位名称",
                          @"请选择你擅长的领域"
                          ];
    }
    return _detitieArray;
}

- (RTHEditInformationFooterView *)footer {
    if (_footer == nil) {
        _footer = [RTHEditInformationFooterView viewFromNib];
        __weak typeof(self) weakSelf = self;
        [_footer.displayView setAddPcitureAction:^{
            [weakSelf openAlbum];
        }];
    }
    return _footer;
}

@end
