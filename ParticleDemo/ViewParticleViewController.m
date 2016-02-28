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
@property (nonatomic, strong) CAEmitterCell *emitterCell;
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end


@implementation ViewParticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ViewParticleViewController plist is %@", self.pList);
    
    self.emitterPreviewView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:1. alpha:0.1];
    
    self.emitterCell = [[CAEmitterCell alloc] init];
    UIImage *cellImage = [UIImage imageNamed:[self.pList objectForKey:@"contents"]];
    self.emitterCell.contents = (__bridge id _Nullable)(cellImage.CGImage);
    self.emitterCell.name = [self.pList objectForKey:@"name"];
    NSLog(@"self.emitterCell.name=%@", self.emitterCell.name);
    self.emitterCell.birthRate = [[self.pList objectForKey:@"birthRate"] doubleValue];
    self.emitterCell.lifetime = [[self.pList objectForKey:@"lifetime"] doubleValue];
    self.emitterCell.lifetimeRange = [[self.pList objectForKey:@"lifetimeRange"] doubleValue];
    NSArray *colorArr = [self.pList objectForKey:@"color"];
    double red   = [colorArr[0] doubleValue];
    double green = [colorArr[1] doubleValue];
    double blue  = [colorArr[2] doubleValue];
    double alpha = [colorArr[3] doubleValue];
    
    self.emitterCell.color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha].CGColor;
    
    self.emitterCell.redRange = [[self.pList objectForKey:@"redRange"] doubleValue];
    self.emitterCell.redSpeed = [[self.pList objectForKey:@"redSpeed"] doubleValue];
    
    self.emitterCell.blueRange = [[self.pList objectForKey:@"blueRange"] doubleValue];
    self.emitterCell.blueSpeed = [[self.pList objectForKey:@"blueSpeed"] doubleValue];
    
    self.emitterCell.greenRange = [[self.pList objectForKey:@"greenRange"] doubleValue];
    self.emitterCell.greenSpeed = [[self.pList objectForKey:@"greenSpeed"] doubleValue];
    
    self.emitterCell.alphaSpeed = [[self.pList objectForKey:@"alphaSpeed"] doubleValue];

    self.emitterCell.velocity = [[self.pList objectForKey:@"velocity"] doubleValue];
    self.emitterCell.velocityRange = [[self.pList objectForKey:@"velocityRange"] doubleValue];
    
    self.emitterCell.yAcceleration = [[self.pList objectForKey:@"yAcceleration"] doubleValue];
    self.emitterCell.emissionLongitude = [[self.pList objectForKey:@"emissionLongitude"] doubleValue];
    self.emitterCell.emissionRange = [[self.pList objectForKey:@"emissionRange"] doubleValue];
    self.emitterCell.scale = [[self.pList objectForKey:@"scale"] doubleValue];
    self.emitterCell.scaleSpeed = [[self.pList objectForKey:@"scaleSpeed"] doubleValue];
    self.emitterCell.scaleRange = [[self.pList objectForKey:@"scaleRange"] doubleValue];
}

-(void)viewDidAppear:(BOOL)animated {
    CGRect rect = self.emitterPreviewView.frame;
    
    self.emitterLayer = [[CAEmitterLayer alloc] init];
    self.emitterLayer.emitterCells = @[self.emitterCell];
    
    self.emitterLayer.lifetime = self.emitterCell.lifetime;
    [self.emitterPreviewView.layer addSublayer:self.emitterLayer];
    double emitterDim = rect.size.height * .2;
    
    self.emitterLayer.emitterPosition = CGPointMake(rect.size.width/2., rect.size.height/2.);
    
    self.emitterLayer.emitterSize = CGSizeMake(emitterDim, emitterDim);
    //self.emitterLayer.emitterSize = CGSizeMake(self.emitterPreviewView.frame.size.width, self.emitterPreviewView.frame.size.height);
    self.emitterLayer.emitterShape = kCAEmitterLayerRectangle;
    
    [self.emitterPreviewView.layer addSublayer:self.emitterLayer];
}


#pragma mark - UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paramCellId"];
    
    cell.textLabel.text = (NSString *)[self.pList objectForKey:@"name"];
    
    return cell;
}


#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
