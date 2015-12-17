//
//  FlickrPhotoCollectionViewCell.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSURL *imageURL;
@end

NS_ASSUME_NONNULL_END
