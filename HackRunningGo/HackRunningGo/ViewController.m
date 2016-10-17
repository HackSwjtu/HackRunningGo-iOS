//
//  ViewController.m
//  HackRunningGo
//
//  Created by Desgard_Duan on 16/10/17.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ViewController.h"
#import "BaiduAPI.h"

@interface ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.mapView.delegate = self;
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];
}

@end
