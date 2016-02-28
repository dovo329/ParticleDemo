//
//  ViewParticleViewController.m
//  ParticleDemo
//
//  Created by Douglas Voss on 2/27/16.
//  Copyright © 2016 VossWareLLC. All rights reserved.
//

#import "ViewParticleViewController.h"

@interface ViewParticleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *emitterPreviewView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *emitterCellsArr;
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) NSArray *tableViewDataSource;
@property (nonatomic, strong) UIColor *color1;
@property (nonatomic, strong) UIColor *color2;

@end


@implementation ViewParticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"ViewParticleViewController plist is %@", self.p
    
    //self.emitterPreviewView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:1. alpha:0.1];
    
    NSArray *colorArr = [self.pList objectForKey:@"backgroundColor"];
    double red = [colorArr[0] doubleValue];
    double green = [colorArr[1] doubleValue];
    double blue = [colorArr[2] doubleValue];
    double alpha = [colorArr[3] doubleValue];
    
    self.color1 = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    self.color2 = [self invertColor:self.color1];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.emitterPreviewView.backgroundColor = self.color1;
    
    self.tableView.backgroundColor = self.color2;
    
    [self initEmitterCells];
    
    self.tableViewDataSource = @[
        @"Cell Mania!",
        @"CAEmitterLayer === Fun",
        @"Particle Power!"];
}


-(void)initEmitterCells {
   
    self.emitterCellsArr = [NSMutableArray new];
    
    NSArray *cellParamArr = [self.pList objectForKey:@"cells"];
    
    for (NSDictionary *cellDict in cellParamArr) {
        
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        
        UIImage *cellImage = [UIImage imageNamed:[cellDict objectForKey:@"contents"]];
        cell.contents = (__bridge id _Nullable)(cellImage.CGImage);
        
        NSArray *colorArr = [cellDict objectForKey:@"color"];
        double red   = [colorArr[0] doubleValue];
        double green = [colorArr[1] doubleValue];
        double blue  = [colorArr[2] doubleValue];
        double alpha = [colorArr[3] doubleValue];
        cell.color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha].CGColor;
        
        cell.redRange = [[cellDict objectForKey:@"redRange"] doubleValue];
        
        cell.greenRange = [[cellDict objectForKey:@"greenRange"] doubleValue];
        
        cell.blueRange = [[cellDict objectForKey:@"blueRange"] doubleValue];
        
        cell.alphaRange = [[cellDict objectForKey:@"alphaRange"] doubleValue];
        
        cell.redSpeed = [[cellDict objectForKey:@"redSpeed"] doubleValue];
        
        cell.greenSpeed = [[cellDict objectForKey:@"greenSpeed"] doubleValue];
        
        cell.blueSpeed = [[cellDict objectForKey:@"blueSpeed"] doubleValue];
        
        cell.alphaSpeed = [[cellDict objectForKey:@"alphaSpeed"] doubleValue];
        
        cell.scale = [[cellDict objectForKey:@"scale"] doubleValue];
        
        cell.scaleRange = [[cellDict objectForKey:@"scaleRange"] doubleValue];
        
        cell.name = [cellDict objectForKey:@"name"];
        //NSLog(@"cell.name=%@", cell.name);
        
        cell.spin = [[cellDict objectForKey:@"spin"] doubleValue];
        
        cell.spinRange = [[cellDict objectForKey:@"spinRange"] doubleValue];
        
        cell.emissionLongitude = [[cellDict objectForKey:@"emissionLatitude"] doubleValue];
        
        cell.emissionLongitude = [[cellDict objectForKey:@"emissionLongitude"] doubleValue];
        
        cell.emissionRange = [[cellDict objectForKey:@"emissionRange"] doubleValue];
        
        cell.lifetime = [[cellDict objectForKey:@"lifetime"] doubleValue];
        cell.lifetimeRange = [[cellDict objectForKey:@"lifetimeRange"] doubleValue];
        
        cell.birthRate = [[cellDict objectForKey:@"birthRate"] doubleValue];
        
        cell.scaleSpeed = [[cellDict objectForKey:@"scaleSpeed"] doubleValue];

        cell.velocity = [[cellDict objectForKey:@"velocity"] doubleValue];
        
        cell.velocityRange = [[cellDict objectForKey:@"velocityRange"] doubleValue];

        cell.xAcceleration = [[cellDict objectForKey:@"xAcceleration"] doubleValue];
        
        cell.yAcceleration = [[cellDict objectForKey:@"yAcceleration"] doubleValue];
        
        cell.zAcceleration = [[cellDict objectForKey:@"zAcceleration"] doubleValue];
        
        [self.emitterCellsArr addObject:cell];
    }
}


-(void)initEmitterLayer {
    CGRect rect = self.emitterPreviewView.frame;
    
    NSDictionary *layerDict = [self.pList objectForKey:@"layer"];
    
    self.emitterLayer = [[CAEmitterLayer alloc] init];
    self.emitterLayer.emitterCells = self.emitterCellsArr;
    
    [self.emitterPreviewView.layer addSublayer:self.emitterLayer];
    
    double sizeMult = [[layerDict objectForKey:@"size"] doubleValue];
    double emitterDim = rect.size.width * sizeMult;
    
    self.emitterLayer.emitterPosition = CGPointMake(rect.size.width/2., rect.size.height/2.);
    
    self.emitterLayer.emitterSize = CGSizeMake(emitterDim, emitterDim);

    NSString *shape = [layerDict objectForKey:@"shape"];
    if ([shape isEqualToString:@"point"]) {
        self.emitterLayer.emitterShape = kCAEmitterLayerPoint;

    } else if ([shape isEqualToString:@"line"]) {
        self.emitterLayer.emitterShape = kCAEmitterLayerLine;
        
    } else if ([shape isEqualToString:@"rectangle"]) {
        self.emitterLayer.emitterShape = kCAEmitterLayerRectangle;
        
    } else if ([shape isEqualToString:@"cuboid"]) {
        self.emitterLayer.emitterShape = kCAEmitterLayerCuboid;
        
    } else if ([shape isEqualToString:@"circle"]) {
        self.emitterLayer.emitterShape = kCAEmitterLayerCircle;

    } else if ([shape isEqualToString:@"sphere"]) {
        self.emitterLayer.emitterShape = kCAEmitterLayerSphere;
        
    } else {
        NSAssert(NO, @"Unknown emitter layer shape");
        self.emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    }
    

    NSString *emitterMode = [layerDict objectForKey:@"emitterMode"];
    if ([emitterMode isEqualToString:@"points"]) {
        self.emitterLayer.emitterMode = kCAEmitterLayerPoints;

    } else if ([emitterMode isEqualToString:@"outline"]) {
        self.emitterLayer.emitterMode = kCAEmitterLayerOutline;
        
    } else if ([emitterMode isEqualToString:@"surface"]) {
        self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
        
    } else if ([emitterMode isEqualToString:@"volume"]) {
        self.emitterLayer.emitterMode = kCAEmitterLayerVolume;
        
    } else {
        NSAssert(NO, @"Unknown emitter layer emitterMode");
        self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    }
    
    
    /*NSString * const kCAEmitterLayerUnordered;
    NSString * const kCAEmitterLayerOldestFirst;
    NSString * const kCAEmitterLayerOldestLast;
    NSString * const kCAEmitterLayerBackToFront;
    NSString * const kCAEmitterLayerAdditive;*/
    
    NSString *renderMode = [layerDict objectForKey:@"renderMode"];
    if ([renderMode isEqualToString:@"unordered"]) {
        self.emitterLayer.renderMode = kCAEmitterLayerUnordered;

    } else if ([renderMode isEqualToString:@"oldestFirst"]) {
        self.emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
        
    } else if ([renderMode isEqualToString:@"oldestLast"]) {
        self.emitterLayer.renderMode = kCAEmitterLayerOldestLast;
        
    } else if ([renderMode isEqualToString:@"backToFront"]) {
        self.emitterLayer.renderMode = kCAEmitterLayerBackToFront;
        
    } else if ([renderMode isEqualToString:@"additive"]) {
        self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
        
    } else {
        NSAssert(NO, @"Unknown emitter layer renderMode");
        self.emitterLayer.renderMode = kCAEmitterLayerUnordered;
    }
    
        
    [self.emitterPreviewView.layer addSublayer:self.emitterLayer];
    [self.view bringSubviewToFront:self.emitterPreviewView];
}


-(void)viewDidAppear:(BOOL)animated {
    
    [self initEmitterLayer];
}


#pragma mark - UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewDataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paramCellId"];
    
    cell.backgroundColor = self.color1;
    cell.textLabel.text = self.tableViewDataSource[indexPath.row];
    
    if ([self getBrightnessOfColor:self.color1] < 0.5) {
        cell.textLabel.textColor = [UIColor whiteColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UIColor *) invertColor:(UIColor *)color
{
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}


-(CGFloat)getBrightnessOfColor:(UIColor *)color {
    CGFloat h,s,b,a;
    [color getHue:&h saturation:&s brightness:&b alpha:&a];
    return b;
}

@end
