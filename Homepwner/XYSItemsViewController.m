//
//  XYSItemsViewController.m
//  Homepwner
//
//  Created by 徐烨晟 on 16-4-10.
//  Copyright (c) 2016年 S. All rights reserved.
//

#import "XYSItemsViewController.h"
#import "XYSItem.h"
#import "XYSItemStore.h"
#import "XYSImageStore.h"
#import "XYSImageViewController.h"
@interface XYSItemsViewController()<UIPopoverControllerDelegate>
@property (nonatomic,strong)IBOutlet UIView *headerView;
@end

@implementation XYSItemsViewController
#pragma mark -init
-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        //for (int i =0 ; i<3; i++) {
         //   [[XYSItemStore sharedStore]createItem];
        //}
        UINavigationItem *navigationItem=self.navigationItem;
        navigationItem.title=@"Homepwner";
        
        //add rightBarButtonItem and leftBarButtonItem
        UIBarButtonItem *bbi=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(addNewItem)];
        navigationItem.rightBarButtonItem=bbi;
        navigationItem.leftBarButtonItem=self.editButtonItem;
        
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#if 0
- (IBAction)toggleEditingMode:(UIButton *)sender {
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }
    else
    {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
        
    }
}
-(UIView *)headerView
{
    if (!_headerView) {
        [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}
#endif

#pragma mark -methods
- (void)addNewItem
{
    
        XYSItem *newItem=[[XYSItemStore sharedStore]createItem];
//  NSInteger lastRow =[[[XYSItemStore sharedStore]allItems]indexOfObject:newItem];
//  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    XYSDataDetailViewController *detailViewController = [[XYSDataDetailViewController alloc]initForNewItem:YES];
    detailViewController.item=newItem;
    detailViewController.dismissBlock=^{[self.tableView reloadData];};
    UINavigationController *navigateionController = [[UINavigationController alloc]initWithRootViewController:detailViewController];
    navigateionController.modalPresentationStyle=UIModalPresentationFormSheet;
    //navigateionController.modalPresentationStyle=UIModalPresentationCurrentContext;//--->
    //self.definesPresentationContext=YES;//---------------------------------------------->these two code to not to hide the navigatetioncontroller,ngc is always on the top!
    [self presentViewController:navigateionController animated:YES completion:nil];
    

}
#pragma mark -tableview
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSArray *items=[[XYSItemStore sharedStore]allItems];
        XYSItem *item=items[indexPath.row];
        [[XYSItemStore sharedStore]removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[XYSItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSDataDetailViewController *datailViewController=[[XYSDataDetailViewController alloc]initForNewItem:NO];
    NSArray *items=[[XYSItemStore sharedStore]allItems];
    XYSItem *selectItem=items[indexPath.row];
    datailViewController.item=selectItem;
    [self.navigationController pushViewController:datailViewController animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath//UITableViewDataSource delegate
{
    //UITableViewCell *tableViewCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
    //                                                   reuseIdentifier:@"UITableViewCell"];
    XYSItemCell *itemCell=[tableView dequeueReusableCellWithIdentifier:@"XYSItemCell"];//get XYSItemCell object
    //UITableViewCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
    //                                                               forIndexPath:indexPath];
    NSArray *items=[[XYSItemStore sharedStore]allItems];//first get the allitems
    //indexPath has two property sectoin row
    XYSItem *item=items[indexPath.row];//second get the N item in allitems
    //tableViewCell.textLabel.text=[item description];
    itemCell.nameLable.text=item.itemName;
    itemCell.serialNumberLable.text=item.serialNumber;
    itemCell.valueLable.text=[NSString stringWithFormat:@"$%d",item.valueInDollars];
    itemCell.thumbnailView.image=item.thumbnail;
    
    itemCell.actionBlock = ^{
        NSLog(@"tap the button");
    };
    //__weak *weakcell = itemCell;
    //XYSItemCell *strongcell = weakcell;
    /*
    itemCell.actionBlock=^{
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad)
        {
            NSString *itemKey=item.itemKey;
            UIImage *image = [[XYSImageStore shareStore]imageForKey:itemKey];
            if (!image) {
                return ;
            }
        
        CGRect rect = [self.viewconvertRect :strongcell.thumbnailView.bounds
                                     forView:strongcell.thumbnailView];
        
        XYSImageViewController *ivc = [[XYSImageViewController alloc]init];
        ivc.image = image;
        
        self.imagePopover = [[UIPopoverController alloc]initWithContentViewController:ivc];
        self.imagePopover.delegate= self;
        self.imagePopover.popoverContentSize = CGSizeMake(600,600);
        [self.imagePopover presentPopoverFromRect:rect
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
        
        }
     
    };
     */

    
    
    return itemCell;//tableViewCell;
}


-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePopover = nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section//UITableViewDataSource delegate
{
    return [[[XYSItemStore sharedStore]allItems]count];
}
#pragma mark -view life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    /*creat nib obj*/
    UINib *nib=[UINib nibWithNibName:@"XYSItemCell" bundle:nil];
    /*register nib object*/
    [self.tableView registerNib:nib forCellReuseIdentifier:@"XYSItemCell"];
    UIView *headerView=self.headerView;
    [self.tableView setTableHeaderView:headerView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
@end
