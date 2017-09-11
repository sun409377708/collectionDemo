//
//  HeadView.h
//  CollecionViewDemo
//
//  Created by maoge on 17/5/3.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model, HeadView;

@protocol HeadViewDelegate <NSObject>

- (void)headViewCollectionViewDidIndexPath:(NSIndexPath *)indexPath;

@end

@interface HeadView : UIView

@property (nonatomic, strong) NSArray <Model *>*modelArray;

- (void)BaseCollectionViewDidSelectedIndex:(NSInteger)index;

@property (nonatomic, weak) id <HeadViewDelegate>delegate;

@end
