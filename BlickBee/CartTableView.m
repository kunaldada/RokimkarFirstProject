//
//  CartTableView.m
//  BlickBee
//
//  Created by Sanchit Kumar Singh on 11/17/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "CartTableView.h"
#import "CartTableViewCell.h"
#import "BlickbeeAppManager.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
@implementation CartTableView

-(id) initWithFrame:(CGRect)frame andProductsArray:(NSMutableArray*) prodsArray{
    
    self.productArray=prodsArray;
    self.dataSource=self;
    self.delegate=self;
    [self registerNib:[UINib nibWithNibName:@"CartTableViewCell" bundle:nil] forCellReuseIdentifier:@"CartTableViewCell"];
    self.backgroundColor=RGBA(225, 225, 225, 1);
    return [self initWithFrame:frame];
}

-(void) reloadCellWithProduct : (Product *) product{
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.productArray indexOfObject:product] inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    if([product.selectedProductQuantity isEqualToString:@"0"]){
        [self.productArray removeObject:product];
        [self reloadData];
    }
    if([[BlickbeeAppManager sharedInstance]selectedProducts].count==0){
        self.backgroundColor=[UIColor clearColor];
        [self.openHomeVCDelegate openHomeVC];
    }
}

- (NSInteger) numberOfSectionsInTableView : (UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return self.productArray.count;
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    CartTableViewCell *cell = (CartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CartTableViewCell"];
    if(cell==nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell bindData:[self.productArray objectAtIndex:indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.reloadCellDelegate=self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection :(NSInteger) section{
    return 0;
}

-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}
@end
