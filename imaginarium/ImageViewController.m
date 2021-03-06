//
//  ImageViewController.m
//  imaginarium
//
//  Created by 徐烨晟 on 16-4-7.
//  Copyright (c) 2016年 徐烨晟. All rights reserved.
//

#import "ImageViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "AFURLSessionManager.h"
@interface ImageViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ImageViewController

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView=scrollView;
    _scrollView.minimumZoomScale=0.2;
    _scrollView.maximumZoomScale=2;
    _scrollView.delegate=self;
    //self.scrollView.contentSize=self.image? self.image.size:CGSizeZero;
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL=imageURL;
    //self.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];//may block main queue;
    [self startDownloadImage];
}
-(void)startDownloadImage
{
    self.image=nil;
    if (self.imageURL)
    {
/*  use apple api to download
      
        [self.spinner startAnimating];
        NSURLRequest *requst=[NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:requst
        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error)
        {
            if (!error)
            {
                if ([requst.URL isEqual:self.imageURL])
                {
                    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image=image;
                    });
                }
            }
        }];
        [task resume];
 */
/*use AFNetworking*/
        NSURLSessionConfiguration *configuration= [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager  = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                        progress:nil
                                                                     destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                        
                                                                         NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
                                                                         NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
                                                                         NSURL *fileURL = [NSURL fileURLWithPath:path];
                                                                         return fileURL;
                                                                     }
                                                                completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                                   if (!error) {
                                                                       if ([request.URL isEqual:self.imageURL]) {
                                                                           UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
                                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                                             self.image = image;
                                                                         });
                                                                       }
                                                                   }
                                                               }];
        [downloadTask resume];
        
        
    }
    
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
    }
    return _imageView;
}

-(UIImage *)image
{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image
{
    
    self.imageView.image=image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize=self.image? self.image.size:CGSizeZero;
    [self.spinner stopAnimating];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end
