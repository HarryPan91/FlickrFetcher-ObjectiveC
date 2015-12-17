//
//  Photo.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
NS_ASSUME_NONNULL_BEGIN
@property(nonatomic, strong) NSString *unique;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *subtitle;
@property(nonatomic, strong) NSURL *imageURL;
@property(nonatomic, strong) NSURL *thumbnailURL;
@property(nonatomic, strong) NSString *owner;
- (instancetype)initWithPhoto: (NSDictionary<NSString *, id> *)photo;
NS_ASSUME_NONNULL_END
@end
