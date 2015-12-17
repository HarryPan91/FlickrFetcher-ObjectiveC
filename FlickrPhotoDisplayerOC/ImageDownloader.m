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

+ (void)beginDownloadImages: (NSArray<Photo *> *)photos withCompletion:(void (^)(UIImage *, NSURL *))completion {
    for (Photo *photoInfo in photos) {
        [self downloadImageWithURL:photoInfo.thumbnailURL andCompletion:^(UIImage *image) {
            completion(image, photoInfo.imageURL);
        }];
    }
}

+ (void)getDataFromURL: (NSURL * _Nonnull)URL withCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, response, error);
    }] resume];
}

+ (void)downloadImageWithURL: (NSURL *)URL andCompletion:(CompletionType) completion {
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

        [self getDataFromURL:URL withCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
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
