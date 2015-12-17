//
//  PhotosCollectionViewController.m
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "ImageDownloader.h"
#import <UIKit/UIKit.h>
#import "FlickrPhotoCollectionViewCell.h"
#import "ImageViewController.h"

@interface PhotosCollectionViewController ()
@property(nonatomic, copy) NSMutableArray<NSURL *> *imageURLs;
@property(nonatomic, copy) NSMutableArray<UIImage *> *thumbnailImages;
@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"PhotoCollectionViewCell";

- (NSMutableArray *)imageURLs {
    if (_imageURLs == nil) {
        _imageURLs = [[NSMutableArray alloc] init];
    }
    return _imageURLs;
}

- (NSMutableArray *)thumbnailImages {
    if (_thumbnailImages == nil) {
        _thumbnailImages = [[NSMutableArray alloc] init];
    }
    return _thumbnailImages;
}

- (void)setPhotos:(NSArray<Photo *> *)photos {
    _photos = photos;
    [ImageDownloader beginDownloadImages:photos withCompletion:^(UIImage * _Nullable image, NSURL * _Nullable URL) {
        if (image != nil && URL != nil) {
            [self.imageURLs addObject:URL];
            [self.thumbnailImages addObject:image];
            [self.collectionView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.thumbnailImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCollectionViewCell *cell = (FlickrPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = self.thumbnailImages[indexPath.row];
    cell.imageURL = self.imageURLs[indexPath.row];

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = self.thumbnailImages[indexPath.row];
    return CGSizeMake(image.size.width, image.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 10, 20, 10);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowImageSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[ImageViewController class]] && [sender isKindOfClass:[FlickrPhotoCollectionViewCell class]]) {
            ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
            ivc.imageURL = ((FlickrPhotoCollectionViewCell *)sender).imageURL;
        }
    }
}

@end
