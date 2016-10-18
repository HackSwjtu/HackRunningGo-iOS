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

static int INDEX = 1;

@interface ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKRouteSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic, strong) BMKRouteSearch *routeSearch;

@property (nonatomic, strong) NSMutableArray<NSValue *> *testPoints;
@property (nonatomic, strong) NSMutableArray<NSValue *> *routePoints;
@property (nonatomic, strong) NSMutableArray<BMKPolyline *> *polylines;
@property (assign) NSInteger distance;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.routePoints = @[].mutableCopy;
    self.testPoints = @[].mutableCopy;
    self.polylines = @[].mutableCopy;
    self.distance = 0;
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 480)];
    self.mapView.delegate = self;
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
}

- (void)givePoints {
    [self addTestPoint:CLLocationCoordinate2DMake(30.771025, 103.985729)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.768690, 103.987364)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.772452, 103.988141)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.768566, 103.989982)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.768566, 103.989982)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.765339, 103.990072)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.775152, 103.990113)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.769404, 103.991393)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.763314, 103.991707)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.767362, 103.992839)];
    [self addTestPoint:CLLocationCoordinate2DMake(30.772670, 103.993903)];
}

- (void)routeDesign {
    self.routeSearch = [[BMKRouteSearch alloc] init];
    self.routeSearch.delegate = self;
    
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = CLLocationCoordinate2DMake(30.771025, 103.985729);
    start.name = @"home";
    start.cityName = @"上海";
    
    
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    [end setPt:CLLocationCoordinate2DMake(30.768690, 103.987364)];
    end.name = @"123";
    end.cityName = @"上海";
    
    BMKWalkingRoutePlanOption *option = [[BMKWalkingRoutePlanOption alloc] init];
    option.from = start;
    option.to = end;
    
    [self.routeSearch walkingSearch:option];
}

- (void)createRunningRoute {
    if (self.testPoints.count < 1 || INDEX == self.testPoints.count) return;
    self.routeSearch = [[BMKRouteSearch alloc] init];
    self.routeSearch.delegate = self;
    
    NSValue *pnv1 = self.testPoints[INDEX - 1];
    NSValue *pnv2 = self.testPoints[INDEX];
    
    CGPoint pnp1 = [pnv1 CGPointValue];
    CGPoint pnp2 = [pnv2 CGPointValue];
    
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = CLLocationCoordinate2DMake(pnp1.x, pnp1.y);
    
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    end.pt = CLLocationCoordinate2DMake(pnp2.x, pnp2.y);
    
    BMKWalkingRoutePlanOption *option = [[BMKWalkingRoutePlanOption alloc] init];
    option.from = start;
    option.to = end;
    
    [self.routeSearch walkingSearch:option];
    
    INDEX ++;
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
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        self.distance += plan.distance;
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
//        [self.polylines addObject:polyLine];
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
    
    NSLog(@"%@", self.routePoints);
    NSLog(@"%ld", self.distance);
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
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:0.5];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 6.0;
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

- (void)addTestPoint: (CLLocationCoordinate2D)po {
    CGPoint p = CGPointMake(po.latitude, po.longitude);
    NSValue *pv = [NSValue valueWithCGPoint:p];
    [self.testPoints addObject:pv];
}

- (IBAction)logPoints:(id)sender {
    [self givePoints];
    
}
- (IBAction)drawLines:(id)sender {
    self.routePoints = @[].mutableCopy;
    self.distance = 0;
    [self createRunningRoute];
}

@end
