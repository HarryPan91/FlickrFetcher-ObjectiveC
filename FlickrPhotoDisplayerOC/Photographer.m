//
//  Photographer.m
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import "Photographer.h"

@interface Photographer ()

@end

@implementation Photographer

- (void)setPhotos:(NSMutableArray<Photo *> *)photos {
    _photos = photos.mutableCopy;
}

- (instancetype)initWithName: (NSString *)name photos: (NSMutableArray<Photo *> *)photos {
    self = [super init];
    if (self) {
        self.name = name;
        self.photos = photos;
    }
    return self;
}
@end
