//
//  CreatePartyViewController.m
//  Rockolin
//
//  Created by Nacho on 9/13/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import "CreatePartyViewController.h"
#import "Parse/Parse.h"
#import "Barcode.h"
#import "StartPartyViewController.h"

@interface CreatePartyViewController ()

@property (nonatomic, strong)PFObject *createdParty;

@end

@implementation CreatePartyViewController
@synthesize partyName = _partyName;
@synthesize partyLocation = _partyLocation;
@synthesize qrView = _qrView;
@synthesize createdParty = _createdParty;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPartyName:nil];
    [self setPartyLocation:nil];
    [self setQrView:nil];
    [self setQrView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)createParty:(UIButton *)sender {
    
    if (self.createdParty) {
        [self performSegueWithIdentifier:@"Lets Party" sender:self];
    }else{
        
        [self.partyName resignFirstResponder];
        [self.partyLocation resignFirstResponder];
        
        PFUser *currentUser = [PFUser currentUser];
        
        PFObject *newParty = [PFObject objectWithClassName:@"party"];
        [newParty setObject:currentUser forKey:@"user"];
        [newParty setObject:self.partyName.text forKey:@"name"];
        [newParty setObject:self.partyLocation.text forKey:@"address"];
        [newParty save];
    
        NSString *code = newParty.objectId;
    
        Barcode *barcode = [[Barcode alloc] init];
    
        [barcode setupQRCode:code];
        [self.qrView setImage:barcode.qRBarcode];
    
        [self setCreatedParty:newParty];
        
        [sender setTitle:@"Lets Party!" forState:UIControlStateNormal];
        
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setParty:self.createdParty];
}
@end
