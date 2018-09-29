//
//  MPTableViewAdPlacerView.h
//  MoPub
//
//  Copyright (c) 2014 MoPub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPNativeAdRendering.h"

@interface MPTableViewAdPlacerView : UITableViewCell <MPNativeAdRendering>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *ctaLabel;
@property (weak, nonatomic) IBOutlet UILabel *adBadgeLabel;
@property (strong, nonatomic) UIImageView *iconImageView;


@end
