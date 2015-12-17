//
//  FlickrPhotoCollectionViewCell.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhotoCollectionViewCell : UICollectionViewCell
NS_ASSUME_NONNULL_BEGIN
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSURL *imageURL;
NS_ASSUME_NONNULL_END
@end
