//
//  NRMetadataView.m
//  Photo Bombers
//
//  Created by Nick Ross on 7/1/14.
//  Copyright (c) 2014 Nick Ross. All rights reserved.
//

#import "NRMetadataView.h"
#import "NRPhotoController.h"
#import <SAMCategories/NSDate+SAMAdditions.h>

@interface NRMetadataView ()
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIButton *usernameButton;
@property (nonatomic) UIButton *timeButton;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIButton *commentsButton;
@end

@implementation NRMetadataView

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    NSDate *createdAt =[NSDate dateWithTimeIntervalSince1970:[_photo[@"created_time"] doubleValue]];
    [self.timeButton setTitle:[createdAt sam_briefTimeInWords] forState:UIControlStateNormal];

    [NRPhotoController avatarForPhoto:self.photo completion:^(UIImage *image) {
        self.avatarImageView.image = image;
    }];
    // TODO: Set the avatar, username, time, number of likes and number of comments
    [self.usernameButton setTitle:_photo[@"user"][@"username"] forState:UIControlStateNormal];
    [self.commentsButton setTitle:[_photo[@"comments"][@"count"] stringValue] forState:UIControlStateNormal];
    [self.likesButton setTitle:[_photo[@"likes"][@"count"] stringValue] forState:UIControlStateNormal];

    
}


#pragma mark - Actions

- (void)openUser:(id)sender {
    //open link in safari to user profile
    NSURL *baseURL = [NSURL URLWithString:@"http://instagram.com/"];
    NSURL *url = [[NSURL alloc] initWithString:_photo[@"user"][@"username"] relativeToURL:baseURL];
    NSURL *absURL = [url absoluteURL];
    [[UIApplication sharedApplication] openURL:absURL];
}


- (void)openPhoto:(id)sender {
    // open link in safari to photo page
    NSURL *url = [[NSURL alloc] initWithString:_photo[@"link"]];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.usernameButton];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.timeButton];
        [self addSubview:self.likesButton];
        [self addSubview:self.commentsButton];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(320.0f, 400.0f);
}

#pragma mark - UIControls

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 32.0f, 32.0f)];
        _avatarImageView.layer.cornerRadius = 16.0f;
        _avatarImageView.layer.borderColor = [[self class] darkTextColor].CGColor;
        _avatarImageView.layer.borderWidth = 1.0f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.backgroundColor = [UIColor colorWithWhite:(0.95) alpha:1.0f];
        _avatarImageView.userInteractionEnabled = NO;
        
    }
    return _avatarImageView;
}


- (UIButton *)usernameButton {
    if (!_usernameButton) {
        _usernameButton = [[UIButton alloc] initWithFrame:CGRectMake(47.0f, 0.0f, 200.0f, 32.0f)];
        _usernameButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _usernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIColor *textColor = [[self class] darkTextColor];
        [_usernameButton setTitleColor:textColor forState:UIControlStateNormal];
        [_usernameButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_usernameButton addTarget:self action:@selector(openUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _usernameButton;
}


- (UIButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [[UIButton alloc] initWithFrame:CGRectMake(250.0f, 0.0f, 60.0f, 32.0f)];
        _timeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_timeButton setImage:[UIImage imageNamed:@"time"] forState:UIControlStateNormal];
        _timeButton.adjustsImageWhenHighlighted = NO;
        _timeButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        UIColor *textColor = [[self  class] lightTextColor];
        [_timeButton setTitleColor:textColor forState:UIControlStateNormal];
        [_timeButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_timeButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}


- (UIButton *)likesButton {
    if (!_likesButton) {
        _likesButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 360.0f, 50.0f, 40.0f)];
        _likesButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_likesButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likesButton.adjustsImageWhenHighlighted = NO;
        _likesButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        
        
        UIColor *textColor = [[self class] lightTextColor];
        [_likesButton setTitleColor:textColor forState:UIControlStateNormal];
        [_likesButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_likesButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likesButton;
}


- (UIButton *)commentsButton {
    if (! _commentsButton) {
        _commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 360.0f, 50.0f, 40.0f)];
        _commentsButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_commentsButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        _commentsButton.adjustsImageWhenHighlighted = NO;
        _commentsButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _commentsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        UIColor *textColor = [[self class] lightTextColor];
        [_commentsButton setTitleColor:textColor forState:UIControlStateNormal];
        [_commentsButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_commentsButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentsButton;
}


#pragma mark - Private

+ (UIColor *)darkTextColor {
    return [UIColor colorWithRed:0.949f green:0.510f blue:0.380f alpha:1.0f];
}

+ (UIColor *)lightTextColor {
    return [UIColor colorWithRed:0.973f green:0.753f blue:0.686f alpha:1.0f];
}


@end
