//
//  DeliveryDetailViewController.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/19/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "DeliveryDetailViewController.h"
#import "OrderServiceClient.h"
#import "AddAddressViewController.h"
#import "OrderConfirmationViewController.h"
#import "AddressConfirmationViewController.h"

@interface DeliveryDetailViewController ()<addressUpdated,addressRecived>{
    DeliveryDetailTableView *deliveryDetailTableView;
    Order *orderItem;
}

@end

@implementation DeliveryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    deliveryDetailTableView = [[DeliveryDetailTableView alloc]initWithFrames :CGRectMake(0,64, getScreenWidth(), getScreenHeight()-61-64)];
    deliveryDetailTableView.addressDelegate=self;
    deliveryDetailTableView.addressrecievedDelegate=self;
    deliveryDetailTableView.separatorColor=[UIColor clearColor];
    deliveryDetailTableView.backgroundColor=RGBA(225, 225, 225, 1);
    [self.view addSubview:deliveryDetailTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)proceedToPaymentBtnPressed:(id)sender {
    if(self.addressItem){
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddressConfirmationViewController *addressConfirmationVC = [storyBoard instantiateViewControllerWithIdentifier:@"AddressConfirmationViewController"];
        addressConfirmationVC.address=self.addressItem;
        [self.navigationController pushViewController:addressConfirmationVC animated:YES];
    }
}

-(void)addressRecived:(Address *)addressItem{
    self.addressItem=addressItem;
}


-(void) openNewAddress{
    AddAddressViewController *cont = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil andPreviouslySelectedAddress:nil];
    cont.addressDelegate=self;
    UINavigationController *navcont = [[UINavigationController alloc] initWithRootViewController:cont];
    [self.navigationController presentViewController:navcont animated:YES completion:^{
        
    }];
}
-(void) editAddressWithPrevAddress:(Address*)prevAddress{
    AddAddressViewController *cont = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil andPreviouslySelectedAddress:prevAddress];
    cont.addressDelegate=self;
    UINavigationController *navcont = [[UINavigationController alloc] initWithRootViewController:cont];
    [self.navigationController presentViewController:navcont animated:YES completion:^{
        
    }];
}

-(void) addressUpdated{
    [deliveryDetailTableView reloadData];
}


@end
