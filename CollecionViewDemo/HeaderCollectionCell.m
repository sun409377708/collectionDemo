//
//  HeaderCollectionCell.m
//  CollecionViewDemo
//
//  Created by maoge on 17/5/25.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import "HeaderCollectionCell.h"
#import "Model.h"
#import "UIImageView+WebCache.h"

@interface HeaderCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end

@implementation HeaderCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(Model *)dataModel {
    _dataModel = dataModel;
    
    self.titleLabel.text = dataModel.name;
}

- (void)setIsMySelected:(BOOL)isMySelected {
    _isMySelected = isMySelected;
    
    if (isMySelected) {
        
        _titleLabel.textColor = [UIColor orangeColor];
        
        //加载网络图片使用
        //        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:_dataModel.selectedImages]];
        
        self.pictureView.image = [UIImage imageNamed:_dataModel.selectedImages];
        
    }else {
        _titleLabel.textColor = [UIColor darkGrayColor];
        
        //加载网络图片使用
        //        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:_dataModel.images]];
        
        self.pictureView.image = [UIImage imageNamed:_dataModel.images];


    }
}

@end
