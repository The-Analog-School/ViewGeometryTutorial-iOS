//
//  UIScrollViewBoundsExampleViewController.m
//  View Geometry Tutorial
//
//  Created by Christopher Constable on 1/9/14.
//
//

#import "UIScrollViewBoundsExampleViewController.h"

@interface UIScrollViewBoundsExampleViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UILabel* boundsLabel;
@end

@implementation UIScrollViewBoundsExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    
    // Add the sample photos...
    NSInteger numberOfImages = 7;
    for (int i = 0; i < numberOfImages; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sample-photo%02d@2x.jpg", i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, i * 550, 320, 550);
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(320, numberOfImages * 550);
    
    [self.view insertSubview:scrollView atIndex:0];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.boundsLabel.text = NSStringFromCGRect(scrollView.bounds);
    NSLog(@"Scrollview bounds: %@", NSStringFromCGRect(scrollView.bounds));
}

@end
