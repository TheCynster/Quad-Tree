# Description
This is a quad tree that I made for an experiment in Xcode. The purpose of this project was to reduce the number of 
items that needed to be checked for collision.
This quad tree accepts SKSpriteNode objects as items.
I hope that this is useful to somebody.
  

# Initializing
In the header file  
@property QuadTree *quadTree;  
in the implementation file  
_quadTree = [[QuadTree alloc] init];  
[_quadTree newQuadTreeWithBounds:YourCGRect) andScene:Yourscene];  
This creates a new quad tree with the bounds that you specify. 
  

# adding items
[_quadTree insert:YourSKSpriteNode];  
This adds the item you pass to the quad tree and puts it in the node that it belongs in. This is also where nodes are split if they are full.
  

# Removing Items
[_quadTree removeItem:SKSpriteNode];  
This finds the item to be removed from the quad tree and removes it.

# Searching / Querying
YourNSMutableArray = [_quadTree search:YourSKSpriteNode]  
This finds items that are in the same node as the item you passed it and returns the items it finds in an NSMutableArray.


