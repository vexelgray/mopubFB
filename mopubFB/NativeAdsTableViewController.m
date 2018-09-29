//
//  NativeAdsTableViewController.m
//  mopubFB
//
//  Created by javier.pena on 29/9/18.
//  Copyright © 2018 TestMopub. All rights reserved.
//

#import "NativeAdsTableViewController.h"
#import "FBAudienceNetwork/FBAdSettings.h"
#import "MPTableViewAdPlacerView.h"
@import MoPub;

@interface NativeAdsTableViewController () <MPTableViewAdPlacerDelegate>
@property (nonatomic, strong) MPTableViewAdPlacer *placer;
@end

@implementation NativeAdsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([MoPub sharedInstance].shouldShowConsentDialog) {
        [[MoPub sharedInstance] loadConsentDialogWithCompletion:^(NSError *error){
            if (error == nil) {
                [[MoPub sharedInstance] showConsentDialogFromViewController:self completion:nil];
            } else {
                NSLog(@"MoPubSampleApp failed to load consent dialog with error: %@", error);
                
            }
        }];
    }
    
    [self setupAdPlacer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    
    return cell;
}

- (void)setupAdPlacer
{
    
    
    
    // Static native ads
    MPStaticNativeAdRendererSettings *nativeAdSettings = [[MPStaticNativeAdRendererSettings alloc] init];
    nativeAdSettings.renderingViewClass = [MPTableViewAdPlacerView class];
    nativeAdSettings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth, -1.0f);
    };
    
    MPNativeAdRendererConfiguration *mopubConfiguration = [MPStaticNativeAdRenderer rendererConfigurationWithRendererSettings:nativeAdSettings];
    mopubConfiguration.supportedCustomEvents = @[@"MPMoPubNativeCustomEvent",
                                                 @"FacebookNativeCustomEvent"];
    
    MPClientAdPositioning *positioning = [MPClientAdPositioning positioning];
    [positioning addFixedIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    [positioning enableRepeatingPositionsWithInterval:5];
    
    
    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    targeting.desiredAssets = [NSSet setWithObjects:kAdIconImageKey, kAdMainImageKey, kAdCTATextKey, kAdTextKey, kAdTitleKey, nil];
    
    // Create a table view ad placer that uses server-side ad positioning.
    self.placer = [MPTableViewAdPlacer placerWithTableView:self.tableView viewController:self adPositioning:positioning rendererConfigurations:@[mopubConfiguration]];
    
    self.placer.delegate = self;
    
    // Load ads (using a test ad unit ID). Feel free to replace this ad unit ID with your own.
    [self.placer loadAdsForAdUnitID:@"935b5286084d451181d122ecad94b218" targeting:targeting];
    
}

#pragma mark - UITableViewAdPlacerDelegate

- (void)nativeAdWillPresentModalForTableViewAdPlacer:(MPTableViewAdPlacer *)placer
{
    NSLog(@"Table view ad placer will present modal.");
}

- (void)nativeAdDidDismissModalForTableViewAdPlacer:(MPTableViewAdPlacer *)placer
{
    NSLog(@"Table view ad placer did dismiss modal.");
}

- (void)nativeAdWillLeaveApplicationFromTableViewAdPlacer:(MPTableViewAdPlacer *)placer
{
    NSLog(@"Table view ad placer will leave application.");
}

@end
