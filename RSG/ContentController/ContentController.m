//
//  ContentController.m
//  ChildIntra
//
//  Created by Rodion Bychkov on 23.06.14.
//  Copyright (c) 2015 Alexander Rodionov & Maya Krivchenya. All rights reserved.
//

#import "ContentController.h"
#import "SectionController.h"

@interface ContentController ()

@end

@implementation ContentController


-(void) awakeFromNib {
    self->controllers = [NSMutableDictionary dictionary];
    self->existingControllers = @[BookSegueKey, DestinationsSegueKey, ProsSegueKey, TouristsSegueKey, FactsSegueKey, AuthorsSegueKey];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showControllerWithStoryboardId: BookSegueKey];

}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self freeAllControllers];
}

-(void) initControllerForKey: (NSString *) key {
    UIViewController *controller = [self->controllers objectForKey: key];
    if (controller == nil) {
        if ([key isEqualToString: ProsSegueKey] || [key isEqualToString: TouristsSegueKey] || [key isEqualToString: FactsSegueKey]) {
            self.currentKey = key;
            [self performSegueWithIdentifier: SectionSegueKey sender: self];
        }
        else {
            self.currentKey = nil;
            [self performSegueWithIdentifier: key sender: self];
        }

    }
    else {
        [self displayContentController: controller];
    }
}

-(void) showControllerWithStoryboardId: (NSString *) stringId {
    if (![self->existingControllers containsObject: stringId]) {
        return;
    }
    if (self.currentController) {
        [self hideContentController: self.currentController completion:^{
            [self initControllerForKey: stringId];
        }];
    }
    else {
        [self initControllerForKey: stringId];
    }
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *dst = segue.destinationViewController;
    
    SWITCH(self.currentKey) {
        UINavigationController *nc = segue.destinationViewController;
        SectionController *sc = (SectionController*)nc.topViewController;
        sc.title = L(self.currentKey);
        CASE(ProsSegueKey) {
            [self->controllers setObject: dst forKey: ProsSegueKey];
            sc.chapterName = @"tips-pros";
            break;
        }
        CASE(TouristsSegueKey) {
            [self->controllers setObject: dst forKey: TouristsSegueKey];
            sc.chapterName = @"tips-tourists";
            break;
        }
        CASE(FactsSegueKey) {
            [self->controllers setObject: dst forKey: FactsSegueKey];
            sc.chapterName = @"facts";
            break;
        }
        DEFAULT {
            [self->controllers setObject: dst forKey: segue.identifier];
            break;
        }
    }
    [self displayContentController: dst];
}


- (void) displayContentController: (UIViewController*) content;
{
    self.currentController = content;
    [self addChildViewController: content];
    [self.view addSubview: content.view];
    [content didMoveToParentViewController:self];
}


- (void) hideContentController: (UIViewController*) content completion:(void (^) (void)) completion
{
    BOOL controllerHasModalChild = NO;
    if (content.childViewControllers.count == 1) {
        UIViewController *vc = content.childViewControllers.firstObject;
        if (vc.presentedViewController) {
            controllerHasModalChild = YES;
            [vc dismissViewControllerAnimated: NO completion:^{
                [content willMoveToParentViewController:nil];
                [content.view removeFromSuperview];
                [content removeFromParentViewController];
                completion();
            }];
        }
    }
    if (!controllerHasModalChild) {
        [content willMoveToParentViewController:nil];
        [content.view removeFromSuperview];
        [content removeFromParentViewController];
        completion();
    }
}


-(void) freeAllControllers {
    self->controllers = [NSMutableDictionary dictionary];
}


@end
