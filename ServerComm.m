//
//  ServerComm.m
//  DokBot
//
//  Created by Sean Patno on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ServerComm.h"
#import "JSON.h"

#define kServerUrl @"https://secure.dokbot.com"

@implementation ServerComm

@synthesize delegate, notJSON;

-(void)authenticateUser:(NSString*)username password:(NSString *)password
{
	NSString *post = [NSString stringWithFormat:@"{\"email\":\"%@\", \"password\" :\"%@\"}",username,password];
	NSURL *testurl =[NSURL URLWithString:@"https://secure.dokbot.com/authentication_tokens.json"];
	
	//NSLog(post);
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:testurl];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	[NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)getJSONWithToken:(NSString*)token from:(NSString*)urlSuffix
{
	
	NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?token=%@",kServerUrl,urlSuffix,token]];
	
	NSLog(@"Get URL: %@",[url absoluteString]);
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:url];
	[request setHTTPMethod:@"GET"];
//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//	[request setHTTPBody:postData];
	
	[NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)post:(NSString *)postBody to:(NSString *)urlExt withToken:(NSString*)token
{
	//NSLog(@"Post data: %@", postBody);
	
	NSURL *testurl =[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?token=%@",kServerUrl,urlExt,token]];
	
	NSLog(@"Post URL: %@",[testurl absoluteString]);
	
	NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:testurl];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	[NSURLConnection connectionWithRequest:request delegate:self];
}

-(void) postStuff:(NSString *)postBody toURL:(NSURL *)url
{

	NSString *post = @"{\"email\":\"seanpatno@gmail.com\", \"password\" :\"secret\"}";
	NSURL *testurl =[NSURL URLWithString:@"https://secure.dokbot.com/authentication_tokens.json"];
	
	//NSLog(post);
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:testurl];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	//[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	//[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	//[request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	/* when we user https, we need to allow any HTTPS cerificates, so add the one line code,to tell teh NSURLRequest to accept any https certificate, i'm not sure about the security aspects
	 */
	
	
	//This is a private api call, do not use
	//[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
	
	//NSError *error;
	//NSURLResponse *response;
	//NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	[NSURLConnection connectionWithRequest:request delegate:self];
	
	//NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
	//NSLog(@"%@",data);
}

#pragma mark -
#pragma mark NSURLConnectionDelegate Stuff

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if(!delegate)
	{
		NSLog(@"delegate was nil. this should not happen!!");
		return;
	}
	
	
	NSMutableData *d = [[NSMutableData data] retain];
    [d appendData:data];
	
    NSString *a = [[NSString alloc] initWithData:d encoding:NSASCIIStringEncoding];
		
	NSLog(@"server returned string: %@", a);
	
	if (!notJSON) {
		NSDictionary *object = [a JSONValue];//[parser objectWithString:a error:nil];
		
		if (!object) {
			//NSLog(@"String form server: %@", a);
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"malformed JSON return" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		} 
		//NSLog(@"Server returned: %@",object);
		[delegate serverDidReturn:object];
	}
	else 
	{
		[delegate serverDidReturn:nil];
	}

	
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
-(NSString*) findValueFrom:(NSString*)searchString key:(NSString*)key
{
	NSRange range = [searchString rangeOfString:key];
	
	NSInteger startLoc = (range.location + range.length + 3);
	NSInteger endLoc = [searchString rangeOfString:@"\"" options:NSLiteralSearch range:NSMakeRange(startLoc, [searchString length] - startLoc)].location;
	
	NSString* substring = [searchString substringWithRange:NSMakeRange(startLoc, endLoc- startLoc)];
	
	NSLog(@"%@", substring);
	
	return substring;
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	//if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
	//	if ([trustedHosts containsObject:challenge.protectionSpace.host])
			[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@",[error description]);
}


@end
