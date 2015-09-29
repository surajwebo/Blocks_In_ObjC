//
//  ViewController.m
//  BlocksInObjC
//
//  Created by Suraj on 29/09/15.
//  Copyright © 2015 Suraj. All rights reserved.
//

/*

 Links to refer:
 
 https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html
 http://stackoverflow.com/questions/7936570/objective-c-pass-block-as-parameter
 http://rypress.com/tutorials/objective-c/blocks
 http://fuckingblocksyntax.com/
 http://www.appcoda.com/objective-c-blocks-tutorial/
 http://www.intertech.com/Blog/understanding-objective-c-blocks/
 
 Syntax to declare Block in Objective-C:
 
 As a local variable:
 returnType (^blockName)(parameterTypes) = ^returnType(parameters) {...};
 
 As a property:
 @property (nonatomic, copy) returnType (^blockName)(parameterTypes);
 
 As a method parameter:
 - (void)someMethodThatTakesABlock:(returnType (^)(parameterTypes))blockName;
 
 As an argument to a method call:
 [someObject someMethodThatTakesABlock:^returnType (parameters) {...}];
 
 As a typedef:
 typedef returnType (^TypeName)(parameterTypes);
 TypeName blockName = ^returnType(parameters) {...};

*/


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    #pragma mark - Block with no return type and no parameters
    void (^mySimpleBlock)(void) = ^{
        NSLog(@"This is a block");
    };
    mySimpleBlock(); // Calling/Invoking a Block
    //Output:- This is a block
    /*
     returnType(^blockName)(parameterTypes) = ^(parameters) {
      // statements
    };*/
    
    #pragma mark - Block with return type (double) and 2 parameters (double, double)
    double (^multiplyTwoValues)(double, double) = ^(double firstValue, double secondValue) {
        return firstValue * secondValue;
    };
    double result = multiplyTwoValues(2.5, 5.4);
    NSLog(@"Result: %.2f",result);
    // Output:- Integer is: 13.50
    
    
    #pragma mark - Block accessing outside variable
    int radiusOfCircleInteger = 40;
    radiusOfCircleInteger = 42;
    void (^printRadius)(void) = ^{
        NSLog(@"Radius Of Circle is: %i",radiusOfCircleInteger);
    };
    radiusOfCircleInteger = 44;
    printRadius();
    // Output:- Radius Of Circle is: 42
    // the output is not 44 as Block cannot change the value of the original variable, or even the captured value (it’s captured as a const variable) once the block if defined.
    
    
    #pragma mark -  Use __block Variable to share storage
    __block int diameterOfCircleInteger = 40;
    diameterOfCircleInteger = 42;
    void (^printDiameter)(void) = ^{
        NSLog(@"Diameter Of Circle is: %i",diameterOfCircleInteger);
    };
    diameterOfCircleInteger = 44;
    printDiameter();
    diameterOfCircleInteger = 48;
    NSLog(@"New Diameter Of Circle is: %i",diameterOfCircleInteger);
    // Output:-
    // Diameter Of Circle is: 44
    // New Diameter Of Circle is: 48
    
    // If you need to be able to change the value of a captured variable from within a block, you can use the __block storage type modifier on the original variable declaration. This means that the variable lives in storage that is shared between the lexical scope of the original variable and any blocks declared within that scope.
    
    
    #pragma mark - Call a method with a Block as a Parameter
    [self methodWithBlockAsParameter:^(NSNumber *numOfRows, NSNumber *numberOfColums) {
        NSLog(@"Callback method executed");
        NSLog(@"Number of Rows: %@ & Columns: %@",numOfRows, numberOfColums);
    }];
    
    
    
    #pragma mark - Block as a typdef
    typedef void(^completionBlock)(NSNumber *numberOfCells);
    completionBlock didComplete = ^(NSNumber *numberOfCells) {
        // your code
        NSLog(@"Number of Cells: %@",numberOfCells);
    };
    didComplete([NSNumber numberWithInt:10]);
    // Output:- Number of Cells: 10
    // A typedef allows the programmer to define one Objective-C type as another
    // e.g. typedef int Counter;   defines the type Counter to be equivalent to the int type. This drastically improves code readability.
    
    
    [self findOddValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Method with Block as a parameter
- (void)methodWithBlockAsParameter: (void (^)(NSNumber *numOfRows, NSNumber *numberOfColums))completionBlock {
    /*
     - (void)aMethodWithBlock:(returnType (^)(parameters))blockName {
     // your code
     }
     */
    NSLog(@"Method with Block as a Parameter executed");
    
    // Callback to the method call
    completionBlock([NSNumber numberWithInt:4], [NSNumber numberWithInt:6]);
}


- (void)findOddValue {
    bool (^findOddValueBlock)(int) = ^(int providedValue) {
        if (providedValue % 2 == 0) {
            return NO;
        } else {
            return YES;
        }
    };
    BOOL isValueOdd = findOddValueBlock(3);
    NSLog(@"Value is Odd: %d",isValueOdd);
}

@end
