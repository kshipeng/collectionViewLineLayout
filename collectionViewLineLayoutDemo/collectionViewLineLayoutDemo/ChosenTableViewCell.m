//
//  ChosenTableViewCell.m
//  linkdemo
//
//  Created by 康世朋 on 2016/12/1.
//  Copyright © 2016年 康世朋. All rights reserved.
//

#import "ChosenTableViewCell.h"
#import "Model.h"

@interface ChosenTableViewCell ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UICollectionView *chosenCollectionView;
@property (nonatomic, retain) MyFlowLayout *flowLayout;
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
    _flowLayout = [[MyFlowLayout alloc]init];
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

@implementation MyFlowLayout
- (instancetype) init {
    if (self = [super init]) {
    }
    return self;
}
/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    // 设置CollectionView滚动为水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    ////  |-------[-------]-------|
    ////  |滑动偏移|可视区域 |剩余区域|
    //是整个collectionView在滑动偏移后的当前可见区域的中点
    CGFloat centerX = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    //    CGFloat centerX = self.collectionView.center.x; //这个中点始终是屏幕中点
    //所以这里对collectionView的具体尺寸不太理解，输出的是屏幕大小，但实际上宽度肯定超出屏幕的
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *layoutAttr in array) {
        CGFloat itemCenterX = layoutAttr.center.x;
        
        if (ABS(itemCenterX - centerX) < ABS(offsetAdjustment)) { // 找出最小的offset 也就是最中间的item 偏移量
            offsetAdjustment = itemCenterX - centerX;
        }
        
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment + 10, proposedContentOffset.y);
}

@end
