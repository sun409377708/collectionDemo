//
//  Model.m
//  CollecionViewDemo
//
//  Created by maoge on 17/5/3.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import "Model.h"

@implementation Model

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    
    Model *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
