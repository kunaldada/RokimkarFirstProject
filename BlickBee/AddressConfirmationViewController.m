//
//  AddressConfirmationViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/30/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AddressConfirmationViewController.h"
#import "DeliveryDetailTableViewCell.h"
#import "AddressConfirmationTableViewCell.h"
#import "DeliveryAddressTableViewCell.h"
#import "OrderServiceClient.h"
#import "Order.h"


@interface AddressConfirmationViewController ()<UITableViewDataSource,UITableViewDelegate>{
    Order *orderItem;
}

@end

@implementation AddressConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.addressConfirmationTableView registerNib:[UINib nibWithNibName:@"DeliveryDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeliveryDetailTableViewCell"];
    
        [self.addressConfirmationTableView registerNib:[UINib nibWithNibName:@"DeliveryAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"DeliveryAddressTableViewCell"];
    [self.addressConfirmationTableView registerNib:[UINib nibWithNibName:@"AddressConfirmationTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressConfirmationTableViewCell"];
        
}

- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 3;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return 1;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
   DeliveryDetailTableViewCell *cell = (DeliveryDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DeliveryDetailTableViewCell"];
    if(cell==nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryDetailTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.imageViewFordeliveryDetail.image=[UIImage imageNamed:@"2_b.png"];
    if(indexPath.section==1){
        AddressConfirmationTableViewCell *cellOne = (AddressConfirmationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"AddressConfirmationTableViewCell"];
        if(cellOne==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddressConfirmationTableViewCell" owner:self options:nil];
            cellOne = [nib objectAtIndex:0];
        }
        [cellOne bindDataForOrder:orderItem];
        return cellOne;
    }
    else if (indexPath.section==2){
        DeliveryAddressTableViewCell *cellTwo = (DeliveryAddressTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"DeliveryAddressTableViewCell"];
        if(cellTwo==nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DeliveryAddressTableViewCell" owner:self options:nil];
            cellTwo = [nib objectAtIndex:0];
        }
        cellTwo.itemAddress=self.address;
        return cellTwo;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    if(section==1){
        return 35;
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 90;
    }
    if(indexPath.section==1){
        return 110;
    }
    return 110;
}

@end
