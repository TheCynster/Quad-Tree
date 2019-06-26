//
//  Particle.h
//  Particle Clicker
//
//  Created by Cynthia Buck on 4/28/18.
//  Copyright © 2018 Cynthia Buck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SpriteKit/SpriteKit.h>

@interface QuadTree: NSObject
@property CGRect bounds;
@property SKScene *scene;
@property int maxItems;
@property NSMutableArray *nodes;
@property NSMutableArray *items;
@property QuadTree *quadTree;
-(void)newQuadTreeWithBounds:(CGRect)rect andScene:(SKScene *)scene;
-(bool)withinBounds:(CGRect)rect withItemBounds:(CGRect)itemRect;
-(bool)insert:(SKSpriteNode *)item;
-(void)split;
-(NSMutableArray *)search:(SKSpriteNode *)queryItem;
-(void)removeItem:(SKSpriteNode *)item;
@end
