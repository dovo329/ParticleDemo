//
//  SelectPresetViewController.m
//  ParticleDemo
//
//  Created by Douglas Voss on 2/27/16.
//  Copyright © 2016 VossWareLLC. All rights reserved.
//

#import "SelectPresetViewController.h"

@interface SelectPresetViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *presetArr;

@end

@implementation SelectPresetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presetArr =
    @[
      @"Snow",
      @"Rain",
      @"Sparkles",
      @"Fire",
      @"Smoke",
      @"Firework",
      @"Particle Man"
    ];
}


#pragma mark - UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presetArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectPresetCellId"];
    
    cell.textLabel.text = self.presetArr[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"You selected %@", self.presetArr[indexPath.row]);
}


@end
