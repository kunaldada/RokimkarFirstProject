//
//  Order.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "Order.h"

@implementation Order

-(instancetype) init
{
    self=[super init];
    if(self)
    {
        self.orderId=@"";
        self.customerId=@"";
        self.deliverySlot=@"";
        self.cartId=@"";
        self.orderStatus=@"";
        self.orderProcessingBy=@"";
        self.bikeNo=@"";
        self.orderAmount=@"";
        self.currency=@"";
        self.paymentMethod=@"";
        self.paymentStatus=@"";
        self.billingAddressId=@"";
        self.payuJson=@"";
        self.payuItemTransaction=@"";
        self.payuItemPrice=@"";
        self.payuItemCurrency=@"";
        self.shippingAddressId=@"";
        self.uniqueAddressId=@"";
        self.orderCreatedDate=@"";
        self.orderUpdatedDate=@"";
        self.orderedProducts=[[NSMutableArray alloc] init];
    }
    return self;
}

@end