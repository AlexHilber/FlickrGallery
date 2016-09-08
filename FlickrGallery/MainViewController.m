//
//  ViewController.m
//  FlickrGallery
//
//  Created by Alexandra on 9/8/16.
//  Copyright © 2016 Alexandra. All rights reserved.
//

#import "MainViewController.h"
#import "FlickrManager.h"
#import "FlickrPhotoViewController.h"

//Private properties and methods
@interface MainViewController ()

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (weak, nonatomic) FlickrGalleryCollectionViewController* collectionVC;
@property (strong, nonatomic) NSArray* flickrPhotos;
@property (nonatomic) bool locationSet; //Flag for tracking first time location is set by CLLocationManager

@end

@implementation MainViewController

static NSString* const flickrGalleryVCIdentifier = @"FlickrGalleryCollectionViewController";
//Default location: New York City, NY, USA
static CGFloat const defaultLat = 40.7128f;
static CGFloat const defaultLon = 74.0059f;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setup CLLocationManager
    self.locationSet = NO;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self loadFlickrPhotos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Restore interaction when returning to this vc
    self.refreshButton.enabled = YES;
    [self.collectionVC setEnabled:YES];
}

//Grab reference to child collection view controller for refreshing and delegate set
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:flickrGalleryVCIdentifier]) {
        self.collectionVC = (FlickrGalleryCollectionViewController*)[segue destinationViewController];
        self.collectionVC.delegate = self;
    }
}

- (IBAction)loadFlickrPhotos {
    CGPoint location = CGPointMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    //If location manager failed to authorize, location is nil
    if (self.locationManager.location == nil) {
        CGPoint defaultLocation = CGPointMake(defaultLat, defaultLon);
        self.flickrPhotos = [FlickrManager loadFlickrPhotosForDeviceLocation:defaultLocation];
    } else {
        self.flickrPhotos = [FlickrManager loadFlickrPhotosForDeviceLocation:location];
    }
    
    [self refreshView];
}

- (void)refreshView {
    if (self.collectionVC != nil) {
        [self.collectionVC setFlickrPhotos:self.flickrPhotos];
        [self.collectionVC refreshView];
    }
}

#pragma mark - FlickrPhotoCellTappedDelegate

- (void)cellTapped:(NSURL *)imagePath {
    //Disable interaction to avoid pushing multiple VCs
    self.refreshButton.enabled = NO;
    [self.collectionVC setEnabled:NO];
    
    //Push new VC to show larger image
    FlickrPhotoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FlickrPhotoViewController"];
    [vc setImagePath:imagePath];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error {
    UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Please allow location permissions to see photos from your location. Default images are from New York, New York."
                                                        delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //Refresh photos only if this is the first location update. Rather than update photos constantly, let the user choose when to refresh.
    if (self.locationSet == NO) {
        [self loadFlickrPhotos];
        self.locationSet = YES;
    }
}

@end
