//
//  MPTableViewAdPlacerView.m
//  MoPub
//
//  Copyright (c) 2014 MoPub. All rights reserved.
//

#import "MPTableViewAdPlacerView.h"
#import "MPNativeAdRenderingImageLoader.h"

@implementation MPTableViewAdPlacerView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.adBadgeLabel.text = @"Ad";
    self.adBadgeLabel.textColor = [UIColor whiteColor];
    self.adBadgeLabel.textAlignment = NSTextAlignmentCenter;
    self.adBadgeLabel.layer.cornerRadius = 2.5f;
    self.adBadgeLabel.clipsToBounds = YES;

    self.ctaLabel.layer.cornerRadius = 12.5f;
    self.ctaLabel.clipsToBounds = YES;
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.frame = CGRectMake(24, 23, 60, 60);
    [self.iconImageView.layer setCornerRadius:5.0f];
    [self.iconImageView setClipsToBounds:YES];
    [self addSubview:self.iconImageView];
    

}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.mainTextLabel.frame = CGRectMake(self.mainTextLabel.frame.origin.x, self.mainTextLabel.frame.origin.y, self.mainTextLabel.frame.size.width, [self getLabelHeight:self.mainTextLabel]);
}

#pragma mark - <MPNativeAdRendering>

- (UILabel *)nativeMainTextLabel
{
    return self.mainTextLabel;
}

- (UILabel *)nativeTitleTextLabel
{
    return self.titleLabel;
}

- (UILabel *)nativeCallToActionTextLabel
{
    return self.ctaLabel;
}

-(UIImageView *)nativeIconImageView{

    return self.iconImageView;
}


+ (UINib *)nibForAd{
    
    
    return [UINib nibWithNibName:@"MPTableViewAdPlacerView" bundle:nil];
}

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    // Inspect the configured labels and images to determine appropriate height for given size.width
    
    return CGSizeMake(size.width,  110.0f + [self getLabelHeight:self.mainTextLabel]);
}

@end
