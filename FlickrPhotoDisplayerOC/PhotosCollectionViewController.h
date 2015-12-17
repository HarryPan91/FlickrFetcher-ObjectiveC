//
//  PhotosCollectionViewController.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PhotosCollectionViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout>
NS_ASSUME_NONNULL_BEGIN
@property(nonatomic, copy) NSArray<Photo *> *photos;
NS_ASSUME_NONNULL_END
@end
