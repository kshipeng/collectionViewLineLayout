//
//  SPCollectionViewFlowLayout.m
//  collectionViewLineLayoutDemo
//
//  Created by 康世朋 on 2016/12/2.
//  Copyright © 2016年 康世朋. All rights reserved.
//

#import "SPCollectionViewFlowLayout.h"

@interface SPCollectionViewFlowLayout ()

@property (nonatomic, retain) NSMutableArray *attributeArray;
@property (nonatomic, assign) NSInteger itemCount;

@end

@implementation SPCollectionViewFlowLayout

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
    _attributeArray = [NSMutableArray array];
    //获取item的个数
    _itemCount = (int)[self.collectionView numberOfItemsInSection:0];
    //先设定大圆的半径 取长和宽最短的
    CGFloat radius = MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height)/2;
    //计算圆心位置
    CGPoint center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
    //中间的item
    CGFloat center_item = _itemCount/2;
    int centerItem = floorf(center_item);
    
    //设置每个item的大小为50*50 则半径为25
    for (int i=0; i<_itemCount; i++) {
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        //设置item大小
        if (i == centerItem) {
            attris.size = CGSizeMake(140, 290);
            float x = center.x;
            float y = center.y;
            attris.center = CGPointMake(x, y);
        }
        if (i < centerItem) {
            attris.size = CGSizeMake(140 - (centerItem - i)*20, 290 - (centerItem - i)*20);
            
        }
        if (i > centerItem) {
            attris.size = CGSizeMake(140 - (i - centerItem)*20, 290 - (i - centerItem)*20);
            
        }
        //计算每个item的圆心位置
        /*
         .
         . .
         .   . r
         .     .
         .........
         */
        //计算每个item中心的坐标
        //算出的x y值还要减去item自身的半径大小
//        float x = center.x+cosf(2*M_PI/_itemCount*i)*(radius-25);
//        float y = center.y+sinf(2*M_PI/_itemCount*i)*(radius-25);
//        
//        attris.center = CGPointMake(x, y);
        [_attributeArray addObject:attris];
    }
    for (int i = centerItem - 1; i > -1; i--) {
        UICollectionViewLayoutAttributes *attributes = _attributeArray[i];
        UICollectionViewLayoutAttributes *attributes2= _attributeArray[i+1];
        attributes.center = CGPointMake(attributes2.center.x - attributes2.size.width/2, attributes2.center.y + 20 );
    }
    for (int i = centerItem + 1; i < _attributeArray.count; i++) {
        UICollectionViewLayoutAttributes *attributes = _attributeArray[i];
        UICollectionViewLayoutAttributes *attributes2= _attributeArray[i-1];
        attributes.center = CGPointMake(attributes2.center.x + attributes2.size.width/2, attributes2.center.y + 20 );
    }
}

//设置内容区域的大小
//-(CGSize)collectionViewContentSize{
//    return self.collectionView.frame.size;
//}
//返回设置数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributeArray;
}

/*
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
*/
@end
