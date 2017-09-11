//
//  ViewController.m
//  CollecionViewDemo
//
//  Created by maoge on 17/5/3.
//  Copyright © 2017年 maoge. All rights reserved.
//


#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#define kHeaderViewHeight 60

#define kNavHeight 64

#import "ViewController.h"
#import "Model.h"
#import "HeadView.h"

static NSString * const CollectionCellId = @"CollectionCellId";


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, HeadViewDelegate>

@property (nonatomic, strong) UICollectionView *baseCollectionView;
@property (nonatomic, strong) NSArray <Model *>*modelArray;

@property (nonatomic, weak) HeadView *head;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
}



- (void)setModelArray:(NSArray<Model *> *)modelArray {
    _modelArray = modelArray;
    
    [self.view addSubview:self.baseCollectionView];
    
    [self setHeadView];
    
    [self.baseCollectionView reloadData];
}

#pragma mark -
#pragma mark HeadViewDelegate
- (void)headViewCollectionViewDidIndexPath:(NSIndexPath *)indexPath {
    
    [self.baseCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}


#pragma mark -
#pragma mark dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellId forIndexPath:indexPath];
    
    cell.backgroundColor = randomColor;
    return cell;
}

#pragma mark -
#pragma mark delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    //根据当前 contentoffset获得index
    
    CGFloat width = scrollView.contentSize.width / self.modelArray.count;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;

    // 滑动结束时, 让顶部headerView 主动调用didSelected方法
    [self.head BaseCollectionViewDidSelectedIndex:index];
}


#pragma mark -
#pragma mark setUI

- (void)setHeadView {
    
    HeadView *head = [[HeadView alloc] initWithFrame:CGRectMake(0, kNavHeight, self.baseCollectionView.bounds.size.width, kHeaderViewHeight)];
    head.delegate = self;
    
    _head = head;
    
    head.modelArray = self.modelArray;
    
    [self.view addSubview:head];
}

- (UICollectionView *)baseCollectionView {
    if (!_baseCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kNavHeight);
        
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeaderViewHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _baseCollectionView.delegate = self;
        _baseCollectionView.dataSource = self;
        _baseCollectionView.pagingEnabled = YES;
        
        [_baseCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionCellId];
    }
    return _baseCollectionView;
}



- (void)requestData {
    
    //模拟网络请求回数据
    NSArray *dataArray = @[@{@"name": @"家居", @"images" : @"iconHomeBlack", @"selectedImages" : @"iconHome"},
                           
                           @{@"name": @"健康", @"images" : @"iconHealthyBlack", @"selectedImages" : @"iconHealthy"},
                           
                           @{@"name": @"娱乐", @"images" : @"iconRecreationBlack", @"selectedImages" : @"iconRecreation"},
                           
                           @{@"name": @"户外", @"images" : @"iconOutdoorsBlack", @"selectedImages" : @"iconOutdoors"},
                           
                           @{@"name": @"教育", @"images" : @"iconEducationBlack", @"selectedImages" : @"iconEducation"},
                           
                           @{@"name": @"办公", @"images" : @"iconOfficeBlack", @"selectedImages" : @"iconOffice"},
                           
                           @{@"name": @"安全", @"images" : @"iconSafeBlack", @"selectedImages" : @"iconSafe"},
                           
                           @{@"name": @"经营", @"images" : @"iconManageBlack", @"selectedImages" : @"iconManage"}];
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSDictionary *dict in dataArray) {
        // 字典转模型, 这里可以用YYModel 或 MJExtension
        Model *model = [Model modelWithDict:dict];
        [arrM addObject:model];
    }
    
    self.modelArray = [arrM copy];
}

@end
