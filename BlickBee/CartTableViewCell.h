//
//  CartTableViewCell.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/17/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForProduct;
@property (weak, nonatomic) IBOutlet UILabel *labelForProductTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelForPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelForUnitQuantity;
- (IBAction)addButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *subtractButtonClicked;
@property (weak, nonatomic) IBOutlet UIButton *addButtonClicked;

- (IBAction)subtractButtonClicked:(id)sender;

-(void) bindData : (Product *) product;
@property (weak, nonatomic) IBOutlet UILabel *labelForQuantity;

@end
