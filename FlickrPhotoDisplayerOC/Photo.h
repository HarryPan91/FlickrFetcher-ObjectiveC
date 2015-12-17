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

@property(nonatomic, copy) NSString *unique;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, strong) NSURL *imageURL;
@property(nonatomic, strong) NSURL *thumbnailURL;
@property(nonatomic, copy) NSString *owner;
- (instancetype)initWithPhoto: (NSDictionary<NSString *, id> *)photo;

@end

NS_ASSUME_NONNULL_END
