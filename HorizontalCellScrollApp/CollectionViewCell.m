//
//  CollectionViewCell.m
//  HorizontalCellScrollApp
//
//  Created by Kevin Remigio on 4/27/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 40)];
        _label.text = @"Hello";
        
        [self addSubview:_label];
    }
    return self;
}

@end
