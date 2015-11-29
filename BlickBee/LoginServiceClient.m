//
//  LoginServiceClient.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/15/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "LoginServiceClient.h"

@implementation LoginServiceClient



- (void) signInWithDictionary:(NSMutableDictionary*)inputDict WithSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure
{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"logIn()",
                             @"password": [inputDict objectForKey:@"password"],
                             @"email": [inputDict objectForKey:@"email"],
                             @"access_token": [inputDict objectForKey:@"access_token"]};
    
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            success([self getUserFromRespons:[responseObject objectForKey:@"response_data"]]);
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

- (void) signUpWithDictionary:(NSMutableDictionary*)inputDict WithSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure
{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"signUp()",
                             @"password": [inputDict objectForKey:@"password"],
                             @"email": [inputDict objectForKey:@"email"],
                             @"access_token": [inputDict objectForKey:@"access_token"],
                             @"phone": [inputDict objectForKey:@"phone"],
                             @"name": [inputDict objectForKey:@"name"],
                             @"device_id": [inputDict objectForKey:@"device_id"]};
    
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            success([self getUserFromRespons:[responseObject objectForKey:@"response_data"]]);
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
 {"request":"varifyOTP()", "user_id":"5", "OTP":"545555"}
 */

- (void) verifyOTPWithOTP:(NSString*)otpStr WithSuccess:(void (^) (User* user))success failure:(void (^) (NSError *error)) failure
{
    
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self printApi:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"varifyOTP()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"OTP": otpStr
                             };
    
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"] && [[responseObject objectForKey:@"response_data"] isKindOfClass:[NSDictionary class]]) {
            success([self getUserFromRespons:[responseObject objectForKey:@"response_data"]]);
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

- (void) resendOTPWithSuccess:(void (^) ())success failure:(void (^) (NSError *error)) failure
{
    NSURL *url = [self getBaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self printApi:url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *params = @{@"request": @"resendOTP()",
                             @"user_id": [BlickbeeAppManager sharedInstance].user.userId,
                             @"phone": [BlickbeeAppManager sharedInstance].user.phone
                             };
    manager.responseSerializer.acceptableContentTypes= [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:BASE_URL_STRING parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"response"] isEqualToString:@"success"]) {
            success();
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


-(User*) getUserFromRespons:(NSDictionary*)responseDict{
    User *user = [[User alloc] init];
    user.userId = [responseDict objectForKey:@"id"];
        user.deviceId = [responseDict objectForKey:@"device_id"];
        user.userName = [responseDict objectForKey:@"username"];
        user.name = [responseDict objectForKey:@"name"];
        user.authKey = [responseDict objectForKey:@"auth_key"];
        user.passHash = [responseDict objectForKey:@"password_hash"];
        user.email = [responseDict objectForKey:@"email"];
        user.phone = [responseDict objectForKey:@"phone"];
        user.cartId = [responseDict objectForKey:@"cart_id"];
        user.avatar = [responseDict objectForKey:@"avatar"];
        user.avatarMineType = [responseDict objectForKey:@"avatar_mine_type"];
        user.myWallet = [responseDict objectForKey:@"myWallet"];
        user.accessToken = [responseDict objectForKey:@"access_token"];
    return user;
}

@end
