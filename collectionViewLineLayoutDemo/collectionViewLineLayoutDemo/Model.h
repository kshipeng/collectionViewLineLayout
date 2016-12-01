//
//  Model.h
//  linkdemo
//
//  Created by 康世朋 on 2016/12/1.
//  Copyright © 2016年 康世朋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic,   copy, readonly) NSString *imageUrl;
@property (nonatomic,   copy, readonly) NSString *iconUrl;
@property (nonatomic,   copy, readonly) NSString *label1Str;
@property (nonatomic,   copy, readonly) NSString *label2Str;
@property (nonatomic,   copy, readonly) NSString *label3Str;
@end
