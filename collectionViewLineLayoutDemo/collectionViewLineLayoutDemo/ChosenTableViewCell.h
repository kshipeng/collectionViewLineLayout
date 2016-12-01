//
//  ChosenTableViewCell.h
//  linkdemo
//
//  Created by 康世朋 on 2016/12/1.
//  Copyright © 2016年 康世朋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface ChosenTableViewCell : UITableViewCell

@property (nonatomic, retain) NSArray *dataSource;
- (void)didSelectAtIndexPath:(void(^)(NSIndexPath *indexPath))select;
- (void)didClickAllButton:(void(^)())all;
@end

@interface ChosenCollectionViewCell : UICollectionViewCell

- (void)updateWithModel:(Model *)model;

@end

@interface MyFlowLayout : UICollectionViewFlowLayout

@end
