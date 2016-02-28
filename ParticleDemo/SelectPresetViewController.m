//
//  SelectPresetViewController.m
//  ParticleDemo
//
//  Created by Douglas Voss on 2/27/16.
//  Copyright © 2016 VossWareLLC. All rights reserved.
//

#import "SelectPresetViewController.h"
#import "ViewParticleViewController.h"

#define kGoViewParticleSegueId @"goViewParticleSegueId"

@interface SelectPresetViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *presetNameArr;
@property (nonatomic, assign) long selectedIndex;

@end

@implementation SelectPresetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presetNameArr =
    @[
      @"Snow",
      @"Rain",
      @"Sparkles",
      @"Fire",
      @"Smoke",
      @"Sparkler",
      @"Particle Man"
    ];
}


#pragma mark - UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presetNameArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectPresetCellId"];
    
    cell.textLabel.text = self.presetNameArr[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"You selected %@", self.presetNameArr[indexPath.row]);
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:kGoViewParticleSegueId sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kGoViewParticleSegueId]) {
        
        ViewParticleViewController *destVC = [segue destinationViewController];
        
        NSString *plistName = self.presetNameArr[self.selectedIndex];

        NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *pList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        destVC.pList = pList;
        
    } else {
        NSAssert(NO, @"unknown segue id");
    }
}

@end
