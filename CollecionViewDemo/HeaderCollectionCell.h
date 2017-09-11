//
//  HeaderCollectionCell.h
//  CollecionViewDemo
//
//  Created by maoge on 17/5/25.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface HeaderCollectionCell : UICollectionViewCell

@property (nonatomic, strong) Model *dataModel;

@property (nonatomic, assign) BOOL isMySelected;

@end
