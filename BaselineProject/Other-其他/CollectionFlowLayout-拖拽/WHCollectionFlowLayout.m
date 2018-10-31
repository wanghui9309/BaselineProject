//
//  WHCollectionFlowLayout.m
//  BaselineProject
//
//  Created by WangHui on 2018/10/31.
//  Copyright © 2018 WangHui. All rights reserved.
//

#import "WHCollectionFlowLayout.h"

@interface WHCollectionFlowLayout ()

/** 当前的indexPath */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
/** 拖动cell的截图 */
@property (nonatomic, weak) UIView *snapshotView;

@end

@implementation WHCollectionFlowLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self addObserver];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addObserver];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"collectionView"];
}

#pragma mark - 初始化数据
/**
 添加KVO监听
 */
- (void)addObserver
{
    [self addObserver:self forKeyPath:@"collectionView" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 初始化手势
 */
- (void)initGestureRecognizer
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    longPress.minimumPressDuration = 0.5;
    [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark - observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"collectionView"])
    {
        [self initGestureRecognizer];
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 点击事件
/**
 长按手势事件
 */
- (void)longPressGesture:(UILongPressGestureRecognizer *)recognizer
{
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint location = [recognizer locationInView:self.collectionView];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
            
            if (indexPath == nil) break;
            
            self.currentIndexPath = indexPath;
            // 当前cell
            UICollectionViewCell *targetCell = [self.collectionView cellForItemAtIndexPath:indexPath];
            
            // 得到当前cell的映射(截图)
            UIView *snapshotView = [targetCell snapshotViewAfterScreenUpdates:YES];
            targetCell.hidden = YES;
            snapshotView.center = targetCell.center;
            [self.collectionView addSubview:snapshotView];
            self.snapshotView = snapshotView;
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [recognizer locationInView:self.collectionView];
            // 更新cell的位置
            self.snapshotView.center = point;
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
            
            if (indexPath == nil )  break;
            
            if ([indexPath compare:self.currentIndexPath] != NSOrderedSame)
            {
                // 改变数据源
                if ([self.delegate respondsToSelector:@selector(moveItemAtIndexPath:toIndexPath:)])
                {
                    [self.delegate moveItemAtIndexPath:self.currentIndexPath toIndexPath:indexPath];
                }
                
                [self.collectionView moveItemAtIndexPath:self.currentIndexPath toIndexPath:indexPath];
                
                self.currentIndexPath = indexPath;
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
            
            [UIView animateWithDuration:0.25 animations:^{
                self.snapshotView.center = cell.center;
            } completion:^(BOOL finished) {
                [self.snapshotView removeFromSuperview];
                cell.hidden = NO;
                self.currentIndexPath = nil;
            }];
        }
            break;
            
        default:
        {
            
        }
            break;
    }
}

@end
