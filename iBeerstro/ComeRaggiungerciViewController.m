//
//  ComeRaggiungerciViewController.m
//  iBeerstro
//
//  Created by Stefano Radice on 22/05/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import "ComeRaggiungerciViewController.h"
#import <MapKit/MapKit.h>
#import "BeerstroHQAnnotation.h"

#define METERS_PER_MILE 1609.344

#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.30
#define MAX_DEGREES_ARC 360

@interface ComeRaggiungerciViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@end

@implementation ComeRaggiungerciViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BeerstroHQAnnotation * annotation = [[BeerstroHQAnnotation alloc]init];
    [_myMapView addAnnotation:annotation];
    NSLog(@"Map: %@", _myMapView.annotations);
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
   for (MKAnnotationView *annotationView in views)
    {
        if([annotationView.annotation isKindOfClass:[BeerstroHQAnnotation class]])
        {
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            NSString *coloredPinPath = [[NSBundle mainBundle] pathForResource: @"logo" ofType:@".png"];
            
            UIImage *coloredPinImage = [UIImage imageWithContentsOfFile:coloredPinPath];
            annotationView.image = coloredPinImage;
        }
        NSLog(@"AnnotationView: %@", annotationView);
        NSLog(@"Views: %@", views);
 
 
 
 

//        if (annotationView.annotation == mapView.userLocation)
//        {
//            MKCoordinateSpan span = MKCoordinateSpanMake(0.3,0.3);
//            MKCoordinateRegion region = MKCoordinateRegionMake(mapView.userLocation.coordinate,span);
//            [mapView setRegion:region animated:YES];
//        }
    
}
    
    [self zoomMapViewToFitAnnotations:_myMapView animated:YES];
}




- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    BeerstroHQAnnotation * annotation = view.annotation;
    CLLocationCoordinate2D userLocation = _myMapView.userLocation.coordinate;
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&saddr=%f,%f",annotation.coordinate.latitude,annotation.coordinate.longitude,userLocation.latitude,userLocation.longitude]]];
}

- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapview animated:(BOOL)animated
{
    NSArray *annotations = _myMapView.annotations;
    NSUInteger count = [mapview.annotations count];
    if (count == 0)    return;
    
    MKMapPoint points[count];
    for(int i=0; i<count; i++)
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    
    if( count == 1 )
    {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    [mapview setRegion:region animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
