//
//  FlickrManager.h
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlickrPhoto : NSObject

- (void)initWithPhotoId:(NSString*)photoID farm:(NSString*)farm server:(NSString*)server secret:(NSString*)secret;
- (NSURL*)flickrImageURLWithSize:(NSString*)size;

@end

@interface FlickrManager : NSObject

+ (NSArray*)loadFlickrPhotosForDeviceLocation:(CGPoint)location;

@end