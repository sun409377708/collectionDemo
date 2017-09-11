//
//  Model.h
//  CollecionViewDemo
//
//  Created by maoge on 17/5/3.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *selectedImages;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
