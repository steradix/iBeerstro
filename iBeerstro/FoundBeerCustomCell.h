//
//  FoundBeerCustomCell.h
//  iBeerstro
//
//  Created by Stefano Radice on 28/03/15.
//  Copyright (c) 2015 Vincenzo Pantuso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoundBeerCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end
