//
//  CartViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/17/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CartViewController : UIViewController
- (IBAction)startShoppingButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startShoppingButtonClicked;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForCartViewController;
@property (weak, nonatomic) IBOutlet UIButton *proceedButtonClicked;
- (IBAction)proceedButtonClicked:(id)sender;
@property (strong, nonatomic) NSMutableArray *productArray;
@end