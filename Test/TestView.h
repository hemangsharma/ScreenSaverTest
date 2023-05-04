//
//  TestView.h
//  Test
//
//  Created by Hemang Sharma on 04/05/23.
//

#import <ScreenSaver/ScreenSaver.h>

@interface TestView : ScreenSaverView

@property (nonatomic, assign) CGPoint ballPosition;
@property (nonatomic, assign) CGPoint ballVelocity;
@property (nonatomic, assign) CGFloat ballRadius;

@end
