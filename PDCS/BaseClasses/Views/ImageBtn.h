
#import <UIKit/UIKit.h>

@interface ImageBtn : UIButton
@property(nonatomic, retain)UIImageView *imageView;
@property(nonatomic, retain)UILabel *lb_title;

- (id)initWithFrame:(CGRect)frame Title:(NSString *)title Image:(NSString *)image;
- (id)initWithFrame:(CGRect)frame;
-(void)resetdata:(NSString *)title :(UIImage *)Image;
@end
