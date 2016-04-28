//
//  AFViewController.m
//  HorizontalCellScrollApp
//
//  Created by Kevin Remigio on 4/26/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "AFViewController.h"
#import "AFTableViewCell.h"
#import "CollectionViewCell.h"

@interface AFViewController ()

@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@end

@implementation AFViewController

-(void)loadView {
    [super loadView];
    
    const NSInteger numberOfTableViewRows = 10;
    const NSInteger numberOfCollectionViewCells = 15;
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:numberOfTableViewRows];
    for (NSInteger tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++) {
        NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
        
        for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++) {
            CGFloat red = arc4random() % 255;
            CGFloat green = arc4random() % 255;
            CGFloat blue = arc4random() % 255;
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
            
            [colorArray addObject:color];
        }
        
        [mutableArray addObject:colorArray];
    }
    self.colorArray = [NSArray arrayWithArray:mutableArray];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Yo! this section number:%ld", section+1];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colorArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    AFTableViewCell *cell = (AFTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[AFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //cell.textLabel.text = @"Hello";
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(AFTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.tag;
    
    
    CGFloat horizontalOffSet = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffSet, 0)];
}

#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 132;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UICollectionViewDataSource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *collectionViewArray = self.colorArray[[(AFIndexedCollectionView*)collectionView indexPath].row];
    return collectionViewArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ccell forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 40)];
    label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    
    //fixes repetition in cells
    for (UIView* view in [cell.contentView subviews])
    {
        if ([view isKindOfClass:[UILabel class]])  //Condition if that view belongs to any specific class
        {
            [view removeFromSuperview];
        }
    }
    
    [cell.contentView addSubview:label];

    NSArray *collectionViewArray =  self.colorArray[[(AFIndexedCollectionView*)collectionView indexPath].row];
    cell.backgroundColor = collectionViewArray[indexPath.item];
    //cell.label.text = @"what";


    //[cell.contentView addSubview:label];
//    [self.view addSubview:label];
    
//    //NSLog(@"cell.contentView x:%f y:%f width:%f height:%f", cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, cell.frame.size.height);

    
    
    return cell;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffSet = scrollView.contentOffset.x;
//    NSLog(@"horizontal offset:%f", horizontalOffSet);
    
    UICollectionView *collectionView = (UICollectionView*)scrollView;
    NSInteger index = collectionView.tag;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffSet);
}
@end
