


#import "ImageBtn.h"

@implementation ImageBtn
@synthesize lb_title,imageView;
//创建时直接确定好位置
- (id)initWithFrame:(CGRect)frame Title:(NSString *)title Image:(NSString *)image
{
    self = [super initWithFrame:frame];
    if (self) {

        lb_title = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_title.numberOfLines = 0;
        lb_title.font = [UIFont systemFontOfSize:14.f];
        lb_title.backgroundColor = [UIColor clearColor];
        lb_title.text = title;
        CGSize size = [lb_title.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f]}];
        //假设lb_title与图片、按钮边缘间隔都是10,图片大小50*50
        if (size.width>self.frame.size.width-5-20-5) {
            size.width =self.frame.size.width-5-20-5;
        }
        CGFloat X = (self.frame.size.width -size.width - 20) / 2.0;
        lb_title.frame = CGRectMake(X, 0, size.width, self.frame.size.height);
        [self addSubview:lb_title];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(lb_title.frame.size.width+lb_title.frame.origin.x, (self.frame.size.height-20)/2, 20, 20)];
        imageView.image = [UIImage imageNamed:image];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
    }
    return self;
}
//先创建，后布局
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        lb_title = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_title.numberOfLines = 0;
        lb_title.font = [UIFont systemFontOfSize:14.f];
        lb_title.backgroundColor = [UIColor clearColor];
        [self addSubview:lb_title];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];

        imageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:imageView];
    }
    return self;
}
//更改title内容时可重新布局
-(void)resetdata:(NSString *)title :(UIImage *)Image
{
    lb_title.text = title;
    CGSize size = [lb_title.text sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f]}];
    //假设lb_title与图片、按钮边缘间隔都是10,图片大小50*50
    if (size.width>self.frame.size.width-5-20-5) {
        size.width =self.frame.size.width-5-20-5;
    }
    CGFloat X = (self.frame.size.width -size.width - 20) / 2.0;
    lb_title.frame = CGRectMake(X, 0, size.width, self.frame.size.height);
    imageView.frame = CGRectMake(lb_title.frame.size.width+lb_title.frame.origin.x, (self.frame.size.height-20)/2, 20, 20);
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected == YES) {
        imageView.image = [UIImage imageNamed:@"tab_up_bg"];
    }else if (selected == NO){
        imageView.image = [UIImage imageNamed:@"tab_down_bg"];
    }
}



@end
