//
//  OrderServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/20/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "OrderServiceClient.h"
#import "BlickbeeAppManager.h"
@implementation OrderServiceClient

- (void) makeOrderWithProductArray:(NSMutableArray*)productsArray andAddress:(Address*)address WithSuccess:(void (^) (id responseData))success failure:(void (^) (NSError *error)) failure{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /*
     eq:
     {
     "request": "makeOrder()",
     "user_id": "525",
     "auth_key": "fba047db2b87b402eb0d154e6cc6e0a0",
     "cart_id": "BBCID_1446274757",
     "product_ids": "29,45",
     "product_qnts": "10,2",
     "product_amt": "66,24",
     "billing_id": "340",
     "shipping_id": "340",
     "product_unit_qnt": "500gm,500gm",
     "total_amount": "708.0"
     }
     */
    NSString *productId=@"";
    NSString *productQty=@"";
    NSString *productAmt=@"";
    NSString *productUnitQty=@"";
    for (Product *product in productsArray) {
        productId=[NSString stringWithFormat:@"%@,%@",productId,product.productId];
        productQty=[NSString stringWithFormat:@"%@,%@",productQty,product.productQuantity];
        productAmt=[NSString stringWithFormat:@"%@,%@",productAmt,product.productPrice];
        productUnitQty=[NSString stringWithFormat:@"%@,%@",productUnitQty,product.productUnitQty];
    }
    
    productId = [productId substringFromIndex:1];
    productQty = [productQty substringFromIndex:1];
    productAmt = [productAmt substringFromIndex:1];
    productUnitQty = [productUnitQty substringFromIndex:1];
    
    NSDictionary *params = @{@"request": @"makeOrder()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"auth_key": [BlickbeeAppManager sharedInstance].user.authKey,
                             @"cart_id": @"",
                             @"product_ids": productId,
                             @"product_qnts": productQty,
                             @"product_amt": productAmt,
                             @"billing_id": address.addressId,
                             @"shipping_id": address.addressId,
                             @"product_unit_qnt": productAmt,
                             @"total_amount": @"708.0"};
    
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            success(nil);
        }
        else{
            failure(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (error.code==-1009) {
            [self showNoNetworkAlert];
            return;
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Error in retrieving information."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        failure(error);
        
    }];
}

/*
 
 response:
 {
	"response": "success",
	"response_data": [{
 "id": "646",
 "customer_id": "525",
 "delivery_slot": "",
 "cart_id": "BBCID_1446274757",
 "order_status": "Pending",
 "order_processing_by": "",
 "bike_no": "0",
 "order_ammount": "708.0",
 "currency": "INR",
 "payment_method": "COD",
 "payment_status": "",
 "billing_address_id": "340",
 "payu_json": "",
 "payu_item_transaction": "",
 "payu_item_price": "",
 "payu_item_currency": "",
 "shipping_address_id": "340",
 "unique_order_id": "BB1219OID652",
 "order_created_date": "2015-11-20 15:48:52",
 "order_updated_date": "2015-11-20 15:48:52",
 "products": [{
 "order_product_id": "29",
 "product_quantities": "10",
 "product_ammount": "66",
 "product_unit_quantity": "500gm",
 "product_name": "Pomegranate -II \/\u0905\u0928\u093e\u0930",
 "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/aJ5Kp4TyU-ZwxxgOTISP1CamfKULDY6r.png"
 }, {
 "order_product_id": "45",
 "product_quantities": "2",
 "product_ammount": "24",
 "product_unit_quantity": "500gm",
 "product_name": "Tomato \/ \u091f\u092e\u093e\u091f\u0930",
 "product_image": "http:\/\/blickbee.com\/admin\/backend\/uploads\/BH9RoA9TT-c9X8Q5XSxebcFsZFSMYNdX.png"
 }]
	}]
 }
 

 
 */


@end
