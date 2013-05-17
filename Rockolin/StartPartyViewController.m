//
//  StartPartyViewController.m
//  Rockolin
//
//  Created by Nacho on 9/13/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import "StartPartyViewController.h"
#import "Barcode.h"

@interface StartPartyViewController ()

@end

@implementation StartPartyViewController
@synthesize party = _party;
@synthesize partyTitle = _partyTitle;
@synthesize qrView = _qrView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setParty:(PFObject *)party
{
    if (party != _party) {
        _party = party;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPartyTitle:nil];
    [self setQrView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.partyTitle setText:[self.party objectForKey:@"name"]];
    Barcode *barcode = [[Barcode alloc] init];
    [barcode setupQRCode:self.party.objectId];
    [self.qrView setImage:barcode.qRBarcode];
    [super viewWillAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
