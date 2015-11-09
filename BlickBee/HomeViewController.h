//
//  HomeViewController.h
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/4/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductRepo.h"
@interface HomeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic) ProductRepo *productRepo;

@end