//
//  DetailViewController.h
//  MultiTaskforSina
//
//  Created by ding orlando on 7/12/13.
//  Copyright (c) 2013 ding orlando. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
