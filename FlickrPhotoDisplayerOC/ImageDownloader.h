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
+ (void)beginDownloadImages: (NSArray<Photo *> * _Nullable)photos withCompletion:(void (^ _Nullable)(UIImage * _Nullable, NSURL * _Nullable))completion;
+ (void)downloadImageWithURL: (NSURL * _Nonnull)URL andCompletion:(CompletionType _Nullable) completion;
@end
