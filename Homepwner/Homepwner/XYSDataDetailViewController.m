//
//  XYSDataDetailViewController.m
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-11.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSDataDetailViewController.h"
#import "XYSItem.h"
#import "XYSItemStore.h"
#import "XYSImageStore.h"
#import "XYSItemCell.h"
@interface XYSDataDetailViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIPopoverControllerDelegate>
@property (strong,nonatomic) UIPopoverController *imagePickerPopover;

@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *itemSerialNumber;
@property (weak, nonatomic) IBOutlet UITextField *itemDollarValue;
@property (weak, nonatomic) IBOutlet UILabel *itemDateCreate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *uiToolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;


@end

@implementation XYSDataDetailViewController

#pragma mark -init
-(instancetype)initForNewItem:(BOOL)isNew
{
    self=[super initWithNibName:nil bundle:nil];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self
                                                                                     action:@selector(save:)];
            self.navigationItem.rightBarButtonItem=doneButton;
            
            UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                       target:self
                                                                                       action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem=cancelButton;
        }
    }
    return self;
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem:" userInfo:nil];
    return nil;
}
-(void)save:(id)sender
{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(void)cancel:(id)sender
{
    [[XYSItemStore sharedStore]removeItem:self.item];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

#pragma mark -imagePickerController
- (IBAction)takePicture:(UIBarButtonItem *)sender
{
    UIImagePickerController *ipc=[[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    ipc.delegate=self;
    //[self presentViewController:ipc animated:YES completion:nil];

    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPad)
    {
        
        if ([self.imagePickerPopover isPopoverVisible]) {
            [self.imagePickerPopover dismissPopoverAnimated:YES];
            self.imagePickerPopover = nil;
            return;
        }
        self.imagePickerPopover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        self.imagePickerPopover.delegate=self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender
                                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                                            animated:YES];
       
    }
    else
    {
        [self presentViewController:ipc animated:YES completion:nil];
    }

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [self.item setThumbnailFromImage:image];
    self.imageView.image=image;
    [[XYSImageStore shareStore]setImage:image forKey:self.item.itemKey];
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPad)
    {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover=nil;
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
#pragma mark -textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.item.itemName = self.itemName.text;
    self.item.serialNumber = self.itemSerialNumber.text;
    self.item.valueInDollars = [self.itemDollarValue.text intValue];
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(void)setItem:(XYSItem *)item
{
    _item=item;
    self.navigationItem.title=item.itemName;
}
#pragma mark -PopoverDelegate
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController//tap other place to close popover
{
    //NSLog(@"user dismissed popover");
    self.imagePickerPopover=nil;
}

#pragma mark -Orientation
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self prepareViewForOrientation:toInterfaceOrientation];
}

-(void)prepareViewForOrientation:(UIInterfaceOrientation)orientation
{
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
        return;
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.cameraButton.enabled =NO;
        self.imageView.hidden=YES;
    }
    else
    {
        self.cameraButton.enabled=YES;
        self.imageView.hidden=NO;
    }
}
#pragma mark -view life cycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    UIInterfaceOrientation io=[[UIApplication sharedApplication]statusBarOrientation];
    [self prepareViewForOrientation:io];
    XYSItem *item=self.item;
    self.itemName.text=item.itemName;
    self.itemSerialNumber.text=item.serialNumber;
    self.itemDollarValue.text=[NSString stringWithFormat:@"%d",item.valueInDollars];
    self.imageView.image=[[XYSImageStore shareStore]imageForKey:item.itemKey];
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter=[[NSDateFormatter alloc ]init];
        dateFormatter.dateStyle=NSDateFormatterMediumStyle;
        dateFormatter.timeStyle=NSDateFormatterNoStyle;
    }
    self.itemDateCreate.text=[dateFormatter  stringFromDate:item.dateCreate];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.itemName.returnKeyType = UIReturnKeyDone;
//    self.itemSerialNumber.returnKeyType = UIReturnKeyDone;
//    self.itemDollarValue.returnKeyType = UIReturnKeyDone;
    self.itemName.delegate = self;
    self.itemSerialNumber.delegate = self;
    self.itemDollarValue.delegate = self;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    XYSItem *item = self.item;
    item.itemName = self.itemName.text;
    item.serialNumber = self.itemSerialNumber.text;
    item.valueInDollars = [self.itemDollarValue.text intValue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
