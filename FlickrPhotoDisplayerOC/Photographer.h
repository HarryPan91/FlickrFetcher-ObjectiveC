//
//  Photographer.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photographer : NSObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSMutableArray<Photo *> *photos;
- (instancetype)initWithName: (NSString *)name photos: (NSMutableArray<Photo *> *)photos;

@end

NS_ASSUME_NONNULL_END
