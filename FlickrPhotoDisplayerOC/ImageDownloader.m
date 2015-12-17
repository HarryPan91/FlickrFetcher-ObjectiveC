//
//  ImageDownloader.m
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import "ImageDownloader.h"
#import "Photo.h"
#import <UIKit/UIKit.h>


static NSCache *imageCache;
static NSMutableDictionary<NSString *, NSMutableArray<CompletionType> *> *imageWithCallbackBlocks;

@implementation ImageDownloader

+ (void)initialize {
    if (self == [ImageDownloader class]) {
        imageCache = [[NSCache alloc] init];
        imageWithCallbackBlocks = [[NSMutableDictionary alloc] init];
    }
}

+ (void)beginDownloadImages: (NSArray<Photo *> *)photos withCompletion:(void (^)(UIImage * _Nullable, NSURL * _Nullable))completion {
    for (Photo *photoInfo in photos) {
        [self downloadImageWithURL:photoInfo.thumbnailURL andCompletion:^(UIImage * _Nullable image) {
            completion(image, photoInfo.imageURL);
        }];
    }
}

+ (void)getDataFromURL: (NSURL * _Nonnull)URL withCompletion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(data, response, error);
    }] resume];
}

+ (void)downloadImageWithURL: (NSURL * _Nonnull)URL andCompletion:(CompletionType) completion {
    UIImage *image = [imageCache objectForKey:URL.absoluteString];
    if (image) {
        completion(image);
    } else {
        NSMutableArray *blocks = imageWithCallbackBlocks[URL.absoluteString];
        if (blocks) {
            [blocks addObject:completion];
            return;
        } else {
            imageWithCallbackBlocks[URL.absoluteString] = @[completion].mutableCopy;
        }

        [self getDataFromURL:URL withCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageCache setObject:image forKey:URL.absoluteString];

                for (CompletionType block in imageWithCallbackBlocks[URL.absoluteString]) {
                    block(image);
                }
                [imageWithCallbackBlocks removeObjectForKey:URL.absoluteString];
            });
        }];
    }

}
@end
