//
//  AFTableViewCell.h
//  HorizontalCellScrollApp
//
//  Created by Kevin Remigio on 4/27/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFIndexedCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

@interface AFTableViewCell : UITableViewCell

@property (nonatomic, strong) AFIndexedCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *) indexPath;

@end
