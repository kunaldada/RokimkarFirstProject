//
//  AddAddressViewController.m
//  BlickBee
//
//  Created by Kunal Chelani on 11/26/15.
//  Copyright © 2015 Sanchit Kumar Singh. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddAddressServiceClient.h"
#import "NearByArea.h"
@interface AddAddressViewController ()
{
    NSMutableArray *regionsArray;
    NSString *headerStr;
    BOOL isDropDown;
    NearByArea *selectedArea;
    Address *selectedAddress;
}
@end

@implementation AddAddressViewController


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPreviouslySelectedAddress:(Address*)prevSelectedAddress{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        selectedAddress=prevSelectedAddress;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    headerStr = @"Select Nearest Area";
    isDropDown=NO;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem =leftBtn;
    leftBtn.tintColor=[UIColor whiteColor];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem =rightBtn;
    rightBtn.tintColor=[UIColor whiteColor];
    self.title=@"Add New Address";
    
    self.nameTextField.layer.cornerRadius = 5.0;
    self.nameTextField.layer.borderWidth = 1.0;
    self.nameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;

    self.phoneNumberTextField.layer.cornerRadius = 5.0;
    self.phoneNumberTextField.layer.borderWidth = 1.0;
    self.phoneNumberTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;

    self.addressTextField.layer.cornerRadius = 5.0;
    self.addressTextField.layer.borderWidth = 1.0;
    self.addressTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;

    self.areasTableView.layer.cornerRadius = 5.0;
    self.areasTableView.layer.borderWidth = 1.0;
    self.areasTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.phoneNumberTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.navigationController.navigationBar.barTintColor=RGBA(246, 71, 17, 1);
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (isDropDown) {
        self.tableViewBottomConstraint.priority=750;
        self.tableViewHeightConstraint.priority=250;
        [self.view updateConstraintsIfNeeded];
    }
    else{
        self.tableViewBottomConstraint.priority=250;
        self.tableViewHeightConstraint.priority=750;
        [self.view updateConstraintsIfNeeded];
    }
    
    if (selectedAddress) {
        self.nameTextField.text = selectedAddress.name;
        self.phoneNumberTextField.text = selectedAddress.phone;
        self.addressTextField.text = selectedAddress.street;
    }
    
    
    if ([BlickbeeAppManager sharedInstance].regionsArray.count>0) {
        regionsArray=[BlickbeeAppManager sharedInstance].regionsArray;
        NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"region == %@",selectedAddress.landmark];
        NSArray *array = [regionsArray filteredArrayUsingPredicate:predicate];
        if (array && array.count>0) {
            selectedArea=[array objectAtIndex:0];
        }
        [self.areasTableView reloadData];
    }
    else{
        AddAddressServiceClient *client = [[AddAddressServiceClient alloc] init];
        [client getNearestAreasWithSuccess:^(NSMutableArray *areasArray) {
            regionsArray=areasArray;
            if (selectedAddress) {
                NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"region == %@",selectedAddress.landmark];
                NSArray *array = [regionsArray filteredArrayUsingPredicate:predicate];
                if (array && array.count>0) {
                    selectedArea=[array objectAtIndex:0];
                }
            }
            [self.areasTableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    if (isDropDown) {
        return regionsArray.count+1;
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView : (UITableView *)tableView cellForRowAtIndexPath : (NSIndexPath *) indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row==0) {
        if (selectedArea) {
            cell.textLabel.text=selectedArea.region;
        }
        else{
            cell.textLabel.text=headerStr;
        }
        UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        accessoryView.image=[UIImage imageNamed:@"dropDown"];
        cell.accessoryView = accessoryView;
    }
    else{
        NearByArea* area;
        if (indexPath.row-1<regionsArray.count) {
            area = [regionsArray objectAtIndex:indexPath.row-1];
        }
        cell.textLabel.text = area.region;
        if (selectedArea.areaId==area.areaId) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    return cell;
}


-(CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
    }
    else{
        selectedArea = [regionsArray objectAtIndex:indexPath.row-1];
    }
    isDropDown=!isDropDown;
    if (isDropDown) {
        self.tableViewBottomConstraint.priority=750;
        self.tableViewHeightConstraint.priority=250;
        [self.view updateConstraintsIfNeeded];
    }
    else{
        self.tableViewBottomConstraint.priority=250;
        self.tableViewHeightConstraint.priority=750;
        [self.view updateConstraintsIfNeeded];
    }
    [tableView reloadData];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{// return NO to disallow editing.
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void) save{
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }
    if ([self.phoneNumberTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the phone number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }
    if ([self.addressTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }
    if (!selectedArea) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please select a nearby area." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return;
    }

    
    if (!selectedAddress) {
        //call for add address
        AddAddressServiceClient *client = [[AddAddressServiceClient alloc] init];
        [client setAddressForName:self.nameTextField.text andNearByArea:selectedArea andPhone:self.phoneNumberTextField.text andStreet:self.addressTextField.text andCity:@"Jodhpur" andState:@"Rajasthan" andPostalCode:@"342001" WithSuccess:^(Address *newAddress) {
            [[BlickbeeAppManager sharedInstance].userAddresses addObject:newAddress];
            [self.addressDelegate addressUpdated];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } failure:^(NSError *error) {
            [self dismissViewControllerAnimated:YES completion:^{
                [[[UIAlertView alloc] initWithTitle:@"" message:@"Failed to update the address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }];
        }];
    }
    else{
        //call for edit address
        AddAddressServiceClient *client = [[AddAddressServiceClient alloc] init];
        [client editAddressForAddressId:selectedAddress.addressId ForName:self.nameTextField.text andNearByArea:selectedArea andPhone:self.phoneNumberTextField.text andStreet:self.addressTextField.text andCity:@"Jodhpur" andState:@"Rajasthan" andPostalCode:@"342001" WithSuccess:^(Address *newAddress) {
            NSInteger replaceAddressAtIndex=0;
            for (int i=0; i<[BlickbeeAppManager sharedInstance].userAddresses.count; i++) {
                Address *existingAddress = [[BlickbeeAppManager sharedInstance].userAddresses objectAtIndex:i];
                if (existingAddress.addressId == selectedAddress.addressId) {
                    replaceAddressAtIndex=i;
                }
            }
            
            ([BlickbeeAppManager sharedInstance].userAddresses)[replaceAddressAtIndex]=newAddress;
            [self.addressDelegate addressUpdated];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];

        } failure:^(NSError *error) {
            [self dismissViewControllerAnimated:YES completion:^{
                [[[UIAlertView alloc] initWithTitle:@"" message:@"Failed to update the address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }];
        }];
    }

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
