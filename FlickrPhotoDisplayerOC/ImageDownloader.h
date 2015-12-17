//
//  ImageDownloader.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Photo.h"

typedef void (^CompletionType)(UIImage * _Nullable);

@interface ImageDownloader : NSObject
+ (void)beginDownloadImages: (nullable NSArray<Photo *> *)photos withCompletion:(void (^ _Nullable)(UIImage * __nullable, NSURL * __nullable))completion;
+ (void)downloadImageWithURL: (nullable NSURL *)URL andCompletion:(nullable CompletionType) completion;
@end
