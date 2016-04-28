//
//  AFTableViewCell.m
//  HorizontalCellScrollApp
//
//  Created by Kevin Remigio on 4/27/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "AFTableViewCell.h"
#import "CollectionViewCell.h"

@implementation AFIndexedCollectionView

@end

@implementation AFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if(!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 9, 10);
    layout.itemSize = CGSizeMake(88, 88);
    
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[AFIndexedCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:ccell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = YES;
    [self.contentView addSubview:self.collectionView];
    
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    //NSLog(@"cell.contentView x:%f y:%f width:%f height:%f", cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, cell.frame.size.height);
    
    self.collectionView.frame = self.contentView.bounds;
}
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath {
    
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    
    [self.collectionView reloadData];

}
@end
