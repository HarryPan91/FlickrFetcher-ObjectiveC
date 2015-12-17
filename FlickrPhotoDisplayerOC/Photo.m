//
//  Photo.m
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"

@interface Photo ()

@end

@implementation Photo
- (instancetype)initWithPhoto: (NSDictionary<NSString *, id> *)photo{
    self = [super init];
    if (self) {
        self.unique = photo[FLICKR_PHOTO_ID];
        self.title = photo[FLICKR_PHOTO_TITLE];
        self.subtitle = photo[FLICKR_PHOTO_DESCRIPTION] ? photo[FLICKR_PHOTO_DESCRIPTION] : @"NO SUBTITLE";
        self.imageURL = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
        self.thumbnailURL = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatSquare];
        self.owner = photo[FLICKR_PHOTO_OWNER];
    }
    return self;
}
@end
