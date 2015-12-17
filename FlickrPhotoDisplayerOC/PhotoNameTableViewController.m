//
//  PhotoNameTableViewController.m
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 16/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import "PhotoNameTableViewController.h"
#import "Photographer.h"
#import "FlickrModel.h"
#import "PhotosCollectionViewController.h"

typedef NSMutableArray<Photographer *> * PhotographerArrayType;

@interface PhotoNameTableViewController ()
@property(nonatomic, copy, nullable) PhotographerArrayType photographers;
@property(nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation PhotoNameTableViewController

- (void)setPhotographers:(PhotographerArrayType)photographers {
    _photographers = photographers.mutableCopy;
}

- (UIActivityIndicatorView *)spinner {
    if (_spinner == nil) {
        _spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _spinner.hidesWhenStopped = YES;
        _spinner.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height / 2.0);
        [[[UIApplication sharedApplication].delegate window] addSubview:_spinner];
    }
    return _spinner;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.spinner startAnimating];

    [FlickrModel fetchWithCompletion:^(PhotographerArrayType photographers) {
        self.photographers = photographers;
        [self.tableView reloadData];
        [self.spinner stopAnimating];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photographers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotographerCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Photographer *p = self.photographers[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Owner: %@", p.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"have %ld photos", (long)p.photos.count];
    return cell;
}

- (IBAction)refresh:(id)sender {
    [self.spinner startAnimating];
    [self.photographers removeAllObjects];
    [self.tableView reloadData];
    [FlickrModel fetchWithCompletion:^(PhotographerArrayType photographers) {
        self.photographers = photographers;
        [self.spinner stopAnimating];
        [self.tableView reloadData];
}];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowPhotosSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[PhotosCollectionViewController class]]) {
            PhotosCollectionViewController *vc = (PhotosCollectionViewController *)segue.destinationViewController;
            Photographer *p = self.photographers[self.tableView.indexPathForSelectedRow.row];
            vc.title = [NSString stringWithFormat:@"%@'s Job", p.name];
            vc.photos = p.photos;
        }
    }
}


@end
