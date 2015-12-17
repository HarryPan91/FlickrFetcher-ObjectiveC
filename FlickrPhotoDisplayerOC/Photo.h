//
//  Photo.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject

@property(nonatomic, strong) NSString *unique;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *subtitle;
@property(nonatomic, strong) NSURL *imageURL;
@property(nonatomic, strong) NSURL *thumbnailURL;
@property(nonatomic, strong) NSString *owner;
- (instancetype)initWithPhoto: (NSDictionary<NSString *, id> *)photo;

@end

NS_ASSUME_NONNULL_END
