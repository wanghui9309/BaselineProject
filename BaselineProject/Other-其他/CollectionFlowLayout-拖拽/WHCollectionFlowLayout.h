//
//  WHCollectionFlowLayout.h
//  BaselineProject
//
//  Created by WangHui on 2018/10/31.
//  Copyright © 2018 WangHui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WHCollectionFlowLayoutDelegate <NSObject>

/**
 移动item到新的位置
 
 @param indexPath 源位置
 @param newIndexPath 新位置
 */
-(void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;

@end

@interface WHCollectionFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<WHCollectionFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
