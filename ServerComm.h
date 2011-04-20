//
//  ServerComm.h
//  DokBot
//
//  Created by Sean Patno on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerCommDelegate

-(void)serverDidReturn:(NSDictionary *)dictionary; 

@end



@interface ServerComm : NSObject<UIAlertViewDelegate> {

	BOOL notJSON;
	id<ServerCommDelegate> delegate;
	
}

@property (nonatomic,assign) BOOL notJSON;
@property (nonatomic,assign) id<ServerCommDelegate> delegate;

-(void) authenticateUser:(NSString*)username password:(NSString*)password;
-(void) postStuff:(NSString*)postBody toURL:(NSURL*)url;
-(void) getJSONWithToken:(NSString *)token from:(NSString *)urlSuffix;
-(void) post:(NSString*)postBody to:(NSString*)urlExt withToken:(NSString*)token;
-(NSString*) findValueFrom:(NSString*)searchString key:(NSString*)key;

@end
