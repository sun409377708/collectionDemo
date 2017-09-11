//
//  HeadView.m
//  CollecionViewDemo
//
//  Created by maoge on 17/5/3.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import "HeadView.h"
#import "HeaderCollectionCell.h"

#define kCollectionCellSpace 16
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

//选项cell宽度, 每页显示5个
#define kItemSizeW (SCREEN_WIDTH - (5 + 1) * kCollectionCellSpace) / 5



static NSString * const CollectionCellId = @"CollectionCellId";


@interface HeadView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property(nonatomic, weak) UIView *indictorView;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setCollectionViewWithFrame:frame];
    }
    
    return self;
}

#pragma mark -
#pragma mark SetUI


- (void)setCollectionViewWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(kItemSizeW, frame.size.height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, kCollectionCellSpace, 0, kCollectionCellSpace);

    flowLayout.minimumLineSpacing = kCollectionCellSpace;
    flowLayout.minimumInteritemSpacing = 0;

    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    _collectionView = collectionView;
    
    [self addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionCell" bundle:nil] forCellWithReuseIdentifier:CollectionCellId];
}


- (void)setModelArray:(NSArray<Model *> *)modelArray {
    _modelArray = modelArray;
    
    [self.collectionView reloadData];
    
    //默认选中第一行
    
}

#pragma mark -
#pragma mark CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellId forIndexPath:indexPath];
    
    cell.dataModel = self.modelArray[indexPath.item];
    
    // 为选中BOOL值赋值, 上一次的赋值为NO , 当前的indexPath为YES
    if (indexPath.item == _selectedIndexPath.item) {
        cell.isMySelected = YES;
    }else {
        cell.isMySelected = NO;
    }
    
    return cell;
}


#pragma mark -
#pragma mark CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 上一个撤销选中
    HeaderCollectionCell *selectedCell = (HeaderCollectionCell *)[collectionView cellForItemAtIndexPath:_selectedIndexPath];
    
    selectedCell.isMySelected = NO;
    
    // 当前的点击选中
    HeaderCollectionCell *cell = (HeaderCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.isMySelected = YES;
    
    // 记录上一个选中的IndexPath
    _selectedIndexPath = indexPath;

    // 将当前的indexPath传递至BaseCollectionView
    if ([self.delegate respondsToSelector:@selector(headViewCollectionViewDidIndexPath:)]) {
        [self.delegate headViewCollectionViewDidIndexPath:indexPath];
    }
    
    // collectionView 滚动至中央位置
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    // 更新
    [_collectionView reloadData];
}

#pragma mark -
#pragma mark 底部BaseCollectionView 滚动结束后调用
- (void)BaseCollectionViewDidSelectedIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];

    [self collectionView:_collectionView didSelectItemAtIndexPath:indexPath];
    
}

@end
