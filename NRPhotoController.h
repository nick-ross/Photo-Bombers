//
//  NRPhotoController.h
//  Photo Bombers
//
//  Created by Nick Ross on 6/30/14.
//  Copyright (c) 2014 Nick Ross. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRPhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

+ (void)avatarForPhoto:(NSDictionary *)photo completion:(void(^)(UIImage *image))completion;

@end
