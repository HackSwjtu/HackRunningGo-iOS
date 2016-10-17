//
//  ViewController.m
//  HackRunningGo
//
//  Created by Desgard_Duan on 16/10/17.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ViewController.h"
#import "BaiduAPI.h"
#import "RouteAnnotation.h"
#import <UIKit/UIKit.h>

@interface ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKRouteSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic, strong) BMKRouteSearch *routeSearch;

@property (nonatomic, strong) NSMutableArray<NSValue *> *routePoints;
@property (assign) NSInteger distance;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.routePoints = @[].mutableCopy;
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 480)];
    self.mapView.delegate = self;
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    [self routeDesign];
}

- (void)routeDesign {
    self.routeSearch = [[BMKRouteSearch alloc] init];
    self.routeSearch.delegate = self;
    
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = CLLocationCoordinate2DMake(31.176517, 121.404209);
    start.name = @"home";
    start.cityName = @"上海";
    
    
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    [end setPt:CLLocationCoordinate2DMake(31.175818, 121.402547)];
    end.name = @"123";
    end.cityName = @"上海";
    
    BMKWalkingRoutePlanOption *option = [[BMKWalkingRoutePlanOption alloc] init];
    option.from = start;
    option.to = end;
    
    
    [self.routeSearch walkingSearch:option];
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];
    // NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        self.distance = plan.distance;
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            // 添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                // TODO: add points
                CLLocationCoordinate2D loc = BMKCoordinateForMapPoint(temppoints[i]);
                [self addPoints:loc];
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [(RouteAnnotation*)annotation getRouteAnnotationView:view];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

- (void)addPoints: (CLLocationCoordinate2D)po {
    CGPoint p = CGPointMake(po.latitude, po.longitude);
    NSValue *pv = [NSValue valueWithCGPoint:p];
    [self.routePoints addObject:pv];
    
//    CLLocationCoordinate2D a = BMKCoordinateForMapPoint(temppoints[i]);
//    NSLog(@"%lf %lf", a.latitude, a.longitude);
}
- (IBAction)logPoints:(id)sender {
    NSLog(@"%@", self.routePoints);
}

@end
