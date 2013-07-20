//
//  PartyViewController.m
//  Rockolin
//
//  Created by Nacho on 9/12/12.
//  Copyright (c) 2012 Rockolin. All rights reserved.
//

#import "PartyViewController.h"
#import "Parse/parse.h"

@interface PartyViewController () <PFLogInViewControllerDelegate>

@property (strong, nonatomic) PFUser *currentUser;

@end

@implementation PartyViewController
@synthesize loginLogoutButton = _loginLogoutButton;
@synthesize userName = _userName;
@synthesize currentUser = _currentUser;

- (void)viewDidLoad
{
    self.currentUser = [PFUser currentUser];
    [self syncLoginLogoutInterface];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //LogIn
    if (![PFUser currentUser]) {
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        logInController.fields = PFLogInFieldsUsernameAndPassword
        | PFLogInFieldsLogInButton
        | PFLogInFieldsSignUpButton
        | PFLogInFieldsPasswordForgotten;
        [self presentModalViewController:logInController animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setLoginLogoutButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)createParty:(id)sender {
}

- (IBAction)launchParty:(id)sender {
}

- (IBAction)joinParty:(id)sender {
}

- (IBAction)loginLogout:(id)sender {
    if (self.currentUser) {
        //[self loadGamesFromParse];
        [PFUser logOut];
        //self.currentUser = [PFUser currentUser];
        [self syncLoginLogoutInterface];
    } else {
        //[self performSegueWithIdentifier:@"LoginSegue" sender:self];
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        [self presentModalViewController:logInController animated:YES];
    }
    
    
}

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    
    [self dismissModalViewControllerAnimated:YES];
    [self syncLoginLogoutInterface];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissModalViewControllerAnimated:YES];
}

- (void) syncLoginLogoutInterface
{
    self.currentUser = [PFUser currentUser];
    if ( ![NSThread isMainThread] )
	{
		[self performSelectorOnMainThread:@selector(syncLoginLogoutInterface) withObject:nil waitUntilDone:NO];
		return;
	}
    
    if (self.currentUser) {
        [self.loginLogoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    }else{
        [self.loginLogoutButton setTitle:@"Login" forState:UIControlStateNormal];
    }
    self.userName.text = self.currentUser.username;
}
@end
