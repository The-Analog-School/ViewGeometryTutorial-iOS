//
//  FrameExampleViewController.m
//  View Geometry Tutorial
//
//  Created by Christopher Constable on 1/9/14.
//
//

#import "FrameExampleViewController.h"

@interface FrameExampleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *frameLabel;
@property (weak, nonatomic) IBOutlet UILabel *boundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;

@property (nonatomic, strong) UIView *imageView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;

@end

@implementation FrameExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeGestures];
    self.imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.imageView.backgroundColor = [UIColor colorWithRed:21.0f / 255.0f
                                                     green:169.0f / 255.0f
                                                      blue:248.0f / 255.0f
                                                     alpha:1.0];
    self.imageView.center = self.view.center;
    [self.view insertSubview:self.imageView atIndex:0];
    
    [self updateLabels];
}

- (void)initializeGestures
{
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(panGestureWasRecognized:)];
    [self.view addGestureRecognizer:self.panGesture];
    self.panGesture.enabled = YES;
    
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(pinchGestureWasRecognized:)];
    [self.view addGestureRecognizer:self.pinchGesture];
    self.pinchGesture.enabled = YES;
}

#pragma mark - Actions

- (void)panGestureWasRecognized:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:self.imageView];
    CGRect newFrame = self.imageView.frame;
    newFrame.origin.x += translation.x;
    newFrame.origin.y += translation.y;
    self.imageView.frame = newFrame;
    [panGesture setTranslation:CGPointZero inView:self.imageView];
    
    if ((panGesture.state == UIGestureRecognizerStateEnded) ||
        (panGesture.state == UIGestureRecognizerStateCancelled)) {
        [self moveImageBackToScreenIfNecessary];
    }
    
    [self updateLabels];
}

- (void)pinchGestureWasRecognized:(UIPinchGestureRecognizer *)pinchGesture
{
    CGPoint oldCenter = self.imageView.center;
    CGRect newFrame = self.imageView.frame;
    newFrame.size.height *= pinchGesture.scale;
    newFrame.size.width *= pinchGesture.scale;
    self.imageView.frame = newFrame;
    self.imageView.center = oldCenter;
    
    pinchGesture.scale = 1.0;
    
    if ((pinchGesture.state == UIGestureRecognizerStateEnded) ||
        (pinchGesture.state == UIGestureRecognizerStateCancelled)) {
        [self moveImageBackToScreenIfNecessary];
    }
    
    [self updateLabels];
}

- (void)updateLabels
{
    self.frameLabel.text = [NSString stringWithFormat:@"X:%0.1f Y:%0.1f W:%0.1f H:%0.1f", self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height];
    
    self.boundsLabel.text = [NSString stringWithFormat:@"X:%0.1f Y:%0.1f W:%0.1f H:%0.1f", self.imageView.bounds.origin.x, self.imageView.bounds.origin.y, self.imageView.bounds.size.width, self.imageView.bounds.size.height];
    
    self.centerLabel.text = [NSString stringWithFormat:@"X:%0.1f Y:%0.1f", self.imageView.center.x, self.imageView.center.y];
}

- (void)moveImageBackToScreenIfNecessary
{
    void(^completionBlock)(BOOL) = ^(BOOL finished) {
        [self updateLabels];
    };
    
    if (self.imageView.frame.origin.x < -(self.imageView.frame.size.width - 50)) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect newRect = self.imageView.frame;
                             newRect.origin.x = -self.imageView.frame.size.width + 50;
                             self.imageView.frame = newRect;
                         }
                         completion:completionBlock];
    }
    if (self.imageView.frame.origin.x > (self.view.bounds.size.width - 50)) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect newRect = self.imageView.frame;
                             newRect.origin.x = self.view.bounds.size.width - 50;
                             self.imageView.frame = newRect;
                         }
                         completion:completionBlock];
    }
    if (self.imageView.frame.origin.y < -(self.imageView.frame.size.height - 50)) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect newRect = self.imageView.frame;
                             newRect.origin.y = -self.imageView.frame.size.height + 50;
                             self.imageView.frame = newRect;
                         }
                         completion:completionBlock];
    }
    if (self.imageView.frame.origin.y > (self.view.bounds.size.height - 50)) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect newRect = self.imageView.frame;
                             newRect.origin.y = self.view.bounds.size.height - 50;
                             self.imageView.frame = newRect;
                         }
                         completion:completionBlock];
    }
}

@end
