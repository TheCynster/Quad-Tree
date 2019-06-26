//
//  Particle.m
//  Particle Clicker
//
//  Created by Cynthia Buck on 4/28/18.
//  Copyright © 2018 Cynthia Buck. All rights reserved.
//
//
// How to use
//  Works with SKSpriteNode objects
//  This quad tree works with SKSpriteNode objects
//  Init with [_quadTree newQuadTreeWithBounds:CGRect) andScene:SKScene];
//  Add items with [_quadTree insert:SKSpriteNode];
//  Remove an item with [_quadTree removeItem:SKSpriteNode];
//  Search the quad tree for items in the same node as the item you pass it [_quadTree search:SKSpriteNode] returns a NSMutableArray


#import "QuadTree.h"

@implementation QuadTree
-(void)newQuadTreeWithBounds:(CGRect)rect andScene:(SKScene *)scene{
    _scene = scene;
    _bounds = rect;
    _maxItems = 4;
    _items = [[NSMutableArray alloc] init];
    _nodes = [[NSMutableArray alloc] init];
}
-(bool)withinBounds:(CGRect)rect withItemBounds:(CGRect)itemRect{
    //checks if an item is within the bounds
    if(itemRect.origin.x + 1 > rect.origin.x && itemRect.origin.x < rect.origin.x + rect.size.width + 1 && itemRect.origin.y - 1 < rect.origin.y && itemRect.origin.y > rect.origin.y + rect.size.height - 1){
      return YES;
    } else{
        return NO;
    }
}
-(bool)insert:(SKSpriteNode *)item{
  //adds the item to the node that falls within the bounds of
    if(![self withinBounds:_bounds withItemBounds:item.calculateAccumulatedFrame]){
        return NO;
    }
    if([_items count] < _maxItems){
        [_items addObject:item];
        return YES;
    }
    if([_nodes count] <= 0){
        [self split];
    }

    if([_nodes[0] insert:item]){
        return YES;
    }
    if([_nodes[1] insert:item]){
        return YES;
    }
    if([_nodes[2] insert:item]){
        return YES;
    }
    if([_nodes[3] insert:item]){
        return YES;
    }
    return NO;
}
-(void)split{
  //Splits a node into 4 nodes
    QuadTree *quadTreeOne = [[QuadTree alloc] init];
    [quadTreeOne newQuadTreeWithBounds:CGRectMake(_bounds.origin.x , _bounds.origin.y,  _bounds.size.width/2, _bounds.size.height/2) andScene:_scene];
    [_nodes addObject:quadTreeOne];

    QuadTree *quadTreeTwo = [[QuadTree alloc] init];
    [quadTreeTwo newQuadTreeWithBounds:CGRectMake(_bounds.origin.x + (_bounds.size.width/2) , _bounds.origin.y,  _bounds.size.width/2, _bounds.size.height/2) andScene:_scene];
    [_nodes addObject:quadTreeTwo];

    QuadTree *quadTreeThree = [[QuadTree alloc] init];
    [quadTreeThree newQuadTreeWithBounds:CGRectMake(_bounds.origin.x, _bounds.origin.y + (_bounds.size.height/2),  _bounds.size.width/2, _bounds.size.height/2) andScene:_scene];
    [_nodes addObject:quadTreeThree];

    QuadTree *quadTreeFour = [[QuadTree alloc] init];
    [quadTreeFour newQuadTreeWithBounds:CGRectMake(_bounds.origin.x + (_bounds.size.width/2) , _bounds.origin.y + (_bounds.size.height/2),  _bounds.size.width/2, _bounds.size.height/2) andScene:_scene];
    [_nodes addObject:quadTreeFour];
}
-(NSMutableArray *)search:(SKSpriteNode *)queryItem{
  //finds the smallest note that the item falls into and returns the items in that node
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if(![self withinBounds:_bounds withItemBounds:queryItem.calculateAccumulatedFrame]){
        return items;
    }
    [items addObjectsFromArray:_items];
    if([_nodes count] <=0 ){
        return items;
    }
    [items addObjectsFromArray:[_nodes[0] search:queryItem]];
    [items addObjectsFromArray:[_nodes[1] search:queryItem]];
    [items addObjectsFromArray:[_nodes[2] search:queryItem]];
    [items addObjectsFromArray:[_nodes[3] search:queryItem]];

    return items;
}
-(void)removeItem:(SKSpriteNode *)item{
  //removes an item from the tree
    if([self withinBounds:_bounds withItemBounds:item.calculateAccumulatedFrame]){
        if([_items containsObject:item]){
            [_items removeObject:item];
            return;
        }else if([_nodes count] > 0){
            [_nodes[0] removeItem:item];
            [_nodes[1] removeItem:item];
            [_nodes[2] removeItem:item];
            [_nodes[3] removeItem:item];
        }
    }
    return;
}
@end
