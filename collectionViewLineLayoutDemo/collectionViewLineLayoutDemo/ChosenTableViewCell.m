//
//  ChosenTableViewCell.m
//  linkdemo
//
//  Created by 康世朋 on 2016/12/1.
//  Copyright © 2016年 康世朋. All rights reserved.
//

#import "ChosenTableViewCell.h"
#import "Model.h"
#import "SPCollectionViewFlowLayout.h"
@interface ChosenTableViewCell ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UICollectionView *chosenCollectionView;
@property (nonatomic, retain) SPCollectionViewFlowLayout *flowLayout;
@property (nonatomic, copy) void(^select)(NSIndexPath *indexPath);
@property (nonatomic, copy) void(^buttonAction)();
@end

@interface ChosenCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end

@implementation ChosenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _flowLayout = [[SPCollectionViewFlowLayout alloc]init];
    _flowLayout.minimumLineSpacing = 0.;
    _flowLayout.minimumInteritemSpacing = 0.;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _chosenCollectionView.collectionViewLayout = _flowLayout;
    [_chosenCollectionView registerNib:[UINib nibWithNibName:@"ChosenCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

}
#pragma mark - 📚集合视图代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //CGFloat height =  width * 1096 / 1334;
    return CGSizeMake(width - 20, self.bounds.size.height - 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChosenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Model *model = self.dataSource[indexPath.row];
    [cell updateWithModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !_select? : _select(indexPath);
}

- (void)didSelectAtIndexPath:(void (^)(NSIndexPath *))select {
    _select = select;
}
- (IBAction)allButtonAction:(id)sender {
    !_buttonAction? : _buttonAction();
}

- (void)didClickAllButton:(void (^)())all {
    _buttonAction = all;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [_chosenCollectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation ChosenCollectionViewCell

- (void)updateWithModel:(Model *)model {
    //_backImageView sd_
    //_iconImageView sd_
    _label1.text = model.label1Str;
    _label2.text = model.label2Str;
    _label3.text = model.label3Str;
}

@end


