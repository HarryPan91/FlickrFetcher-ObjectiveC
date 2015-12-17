//
//  FlickrModel.m
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import "FlickrModel.h"
#import "Photo.h"
#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"

@interface FlickrModel ()
//@property(nonatomic, copy) NSMutableArray<Photographer *> *photographers;
@end

@implementation FlickrModel

+ (void)fetchWithCompletion: (void (^)(NSMutableArray<Photographer *> *))completion {
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[FlickrFetcher URLforRecentGeoreferencedPhotos]];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            NSError *error;
            NSDictionary<NSString *, id> *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error == nil) {
                completion([self loadImagesFromFlickrArray:jsonResult[@"photos"][@"photo"]]);
            } else {
                NSLog(@"Flickr fetch failed: %@", error);
            }
        }
    }];
    [task resume];
}

+ (NSMutableArray<Photographer *> *)loadImagesFromFlickrArray: (NSArray<NSDictionary<NSString *, id> *> *) photos {
    NSMutableArray<Photographer *> *photographers = [[NSMutableArray alloc]init];
    for (NSDictionary *photo in photos) {
        NSString *photographer = photo[FLICKR_PHOTO_OWNER];
        Photo *newPhoto = [[Photo alloc]initWithPhoto:photo];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", photographer];
        NSArray *filteredPhotographers = [photographers filteredArrayUsingPredicate:predicate];
        if (filteredPhotographers.count > 0) {
            Photographer *p = filteredPhotographers.firstObject;
            [p.photos addObject:newPhoto];
        } else {
            [photographers addObject:[[Photographer alloc]initWithName:photographer andPhotos:@[newPhoto].mutableCopy]];
        }
    }
    return photographers;
}

@end
