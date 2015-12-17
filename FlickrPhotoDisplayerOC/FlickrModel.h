//
//  FlickrModel.h
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photographer.h"

@interface FlickrModel : NSObject
+ (void)fetchWithCompletion: (void (^)(NSMutableArray<Photographer *> *))completion;
@end
