//
//  SSDirectory.m
//  SparkleShare
//
//  Created by Sergey Klimov on 07.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SSDirectory.h"

@implementation SSDirectory

//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//http://localhost:3000/api/getFolderItemCount/c0acdbe1e1fec3290db71beecc9af500af126f8d
//4
-(int) count
{
    if (!count){
        //perform
    }
    return count;
}


//$ curl -H "X-SPARKLE-IDENT: qj7cGswA" \
//-H "X-SPARKLE-AUTH: iteLARuURXKzGNJ...solGzbOutrWcfOWaUnm7ZIgNyn-" \
//"http://localhost:3000/api/getFolderContent/c0acdbe1e1fec3290db71beecc9\
//af500af126f8d?path=c&hash=b59993a22c86c5e84973d907bce7a4baf04bdb28&name=c"
//
//[{"id":"79f40baddef287ad225013b9060b10d2388b7306","type":"dir","name":"a","url":"path=c%2Fa&hash=79f40baddef287ad225013b9060b10d2388b7306&name=a"},
//{"id":"21efaca824f4705deeb9ef6025fd879c871a7117","type":"file","name":"d","url":"path=c%2Fd&hash=21efaca824f4705deeb9ef6025fd879c871a7117&name=d"}]
-(NSArray*) items
{
    if (!items){
        //perform
    }
    return items;
}


@end
