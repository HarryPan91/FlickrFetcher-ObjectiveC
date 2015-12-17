//
//  PhotosCollectionViewController.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosCollectionViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>
@property(nonatomic, copy) NSArray<Photo *> *photos;

@end

NS_ASSUME_NONNULL_END
