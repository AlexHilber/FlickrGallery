//
//  FlickrManager.m
//  FlickrGallery
//
//  Created by Aleandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "FlickrManager.h"

//Private properties and methods
@interface FlickrPhoto()

@property (strong, nonatomic) NSString* photoID;
@property (strong, nonatomic) NSString* farm;
@property (strong, nonatomic) NSString* server;
@property (strong, nonatomic) NSString* secret;

@end

@implementation FlickrPhoto

- (void)initWithPhotoId:(NSString*)photoID farm:(NSString*)farm server:(NSString*)server secret:(NSString*)secret {
    self.photoID = photoID;
    self.farm = farm;
    self.server = server;
    self.secret = secret;
 }
 
 - (NSURL*)flickrImageURLWithSize:(NSString*)size {
     return [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_%@.jpg", self.farm, self.server, self.photoID, self.secret, size]];
 }

@end

@implementation FlickrManager

static NSString* const apiKey = @"d9c1ad9ec088e9efb41ffdcc38f01f70";
static int const geoSearchAccuracy = 6; //regional accuracy
static int const numResults = 30;

+ (NSArray*)loadFlickrPhotosForDeviceLocation:(CGPoint)location {
    NSMutableArray* flickrPhotos = [NSMutableArray array];
    
    //With pages not specified, results default to 1 page
    NSString* urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&lat=%g&lon=%g&accuracy=%d&api_key=%@&per_page=%d&format=json&nojsoncallback=1", location.x, location.y, geoSearchAccuracy, apiKey, numResults];
    NSURL* url = [NSURL URLWithString:urlString];

    NSData* jsonData = [NSData dataWithContentsOfURL:url];
    NSDictionary* results = [NSDictionary dictionary];
    if (jsonData != nil) {
        NSError* error = nil;
        results = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error != nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.description
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Flickr connection failed. Please check your internet connection and try refreshing."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSArray* photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    FlickrPhoto* flickrPhoto;
    for (NSDictionary *photo in photos) {
        flickrPhoto = [[FlickrPhoto alloc] init];
        [flickrPhoto initWithPhotoId:[photo objectForKey:@"id"] farm:[photo objectForKey:@"farm"] server:[photo objectForKey:@"server"] secret:[photo objectForKey:@"secret"]];
        [flickrPhotos addObject:flickrPhoto];
    }
    
    return [NSArray arrayWithArray:flickrPhotos];
}

@end
