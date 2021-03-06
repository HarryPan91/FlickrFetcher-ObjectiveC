//
//  ImageViewController.m
//  FlickrPhotoDisplayerOC
//
//  Created by Harry on 17/12/2015.
//  Copyright © 2015 Snaptee. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageDownloader.h"

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ImageDownloader downloadImageWithURL:self.imageURL andCompletion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
