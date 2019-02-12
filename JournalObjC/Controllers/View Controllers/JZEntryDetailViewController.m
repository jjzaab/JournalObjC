//
//  JZEntryDetailViewController.m
//  JournalObjC
//
//  Created by XMS_JZhan on 2/11/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "JZEntryDetailViewController.h"
#import "JZEntry.h"
#import "JZEntryController.h"

@interface JZEntryDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation JZEntryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleTextField.delegate = self;
    self.updateViews;
}

- (void)updateViews
{
    if (_entry) {
        [self.titleTextField setText:_entry.title];
        [self.bodyTextView setText:_entry.text];
    } else {
        return;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES;
}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    if (_entry) {
        self.updateViews;
    } else {
        JZEntry *entry = [[JZEntry alloc] initWithTitle:[self.titleTextField text] text:[self.bodyTextView text] timestamp: [[NSDate alloc] init]];
        [JZEntryController.shared addEntry: entry];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

- (IBAction)clearButtonTapped:(UIButton *)sender {
    [self.bodyTextView setText:@""];
}

@end
