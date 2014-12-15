//
//  LeaveCommentViewController.h
//  iBeerstro
//
//  Created by Stefano Radice on 06/09/14.
//  Copyright (c) 2014 Stefano Radice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveCommentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString*productName;

@end
