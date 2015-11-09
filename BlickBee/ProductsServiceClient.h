//
//  ProductsServiceClient.h
//  BlickBee
//
//  Created by Kunal Chelani on 11/7/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServiceClient.h"
#import "ProductRepo.h"
@interface ProductsServiceClient : BaseServiceClient

- (void) fetchProdctRepoWithSuccess:(void (^) (ProductRepo* repo))success failure:(void (^) (NSError *error)) failure;


@end