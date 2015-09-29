//
//  ViewController.h
//  BlocksInObjC
//
//  Created by Suraj on 29/09/15.
//  Copyright © 2015 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// Block as a Property
@property (nonatomic,copy)void (^completionBlock)(NSArray *array, NSError *error);
//@property (nonatomic, copy) returnType (^blockName)(parameters);


@end

