//
//  DeliveryAddressTableViewCell.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "DeliveryAddressTableViewCell.h"

@implementation DeliveryAddressTableViewCell

- (void)awakeFromNib {
    self.backgroundColor=RGBA(225, 225, 225, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)editButtonClicked:(id)sender {
}

- (IBAction)removeButtonClicked:(id)sender {
}

-(void) bindData:(Address*)address{
    self.nameLabel.text = address.name;
    self.phoneLabel.text = address.phone;
    self.address1Label.text = address.street;
    self.address2Label.text = address.landmark;
}

@end
