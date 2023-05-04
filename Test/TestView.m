//
//  TestView.m
//  Test
//
//  Created by Hemang Sharma on 04/05/23.
//

#import "TestView.h"

@implementation TestView {
    NSTextField *newsLabel;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview {
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        // Initialize news label
        newsLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
        [newsLabel setEditable:NO];
        [newsLabel setBezeled:NO];
        [newsLabel setDrawsBackground:NO];
        [newsLabel setAlignment:NSTextAlignmentCenter];
        [newsLabel setFont:[NSFont systemFontOfSize:20]];
        [self addSubview:newsLabel];
        
        // Fetch news
        [self fetchNews];
    }
    return self;
}

- (void)animateOneFrame {
    [super animateOneFrame];
    
    // Fetch news every 10 seconds
    static NSTimeInterval lastUpdateTime = 0;
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    if (currentTime - lastUpdateTime >= 10) {
        [self fetchNews];
        lastUpdateTime = currentTime;
    }
}

- (void)fetchNews {
    NSURL *url = [NSURL URLWithString:@"https://newsdata.io/api/1/news?apikey=pub_216164e001dbcd536f376f6819abdcdf5e3d4&q=pegasus&language=en"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            NSError *jsonError = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (json && !jsonError) {
                NSArray *articles = json[@"articles"];
                if (articles.count > 0) {
                    NSDictionary *article = articles[0];
                    NSString *title = article[@"title"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Update news label with the latest news
                        [newsLabel setStringValue:title];
                    });
                }
            }
        }
    }];
    [task resume];
}

@end
