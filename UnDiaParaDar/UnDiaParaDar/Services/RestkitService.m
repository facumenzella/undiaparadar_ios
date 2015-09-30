//
//  RestkitService.m
//  UnDiaParaDar
//
//  Created by Facundo Menzella on 9/29/15.
//  Copyright (c) 2015 ITBA. All rights reserved.
//

#import "RestkitService.h"

@interface RestkitService ()

@property (nonatomic, strong) RKObjectManager *manager;

@end

@implementation RestkitService

- (instancetype)initWithBaseURL:(NSString*)baseURL
{
    self = [super init];
    if (self) {
        self.manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseURL]];
    }
    return self;
}

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
         withCallback:(void (^)(RKMappingResult*, NSError*))cb
{
    [self requestToPath:path
             withMethod:method
            withMapping:nil
             withParams:params
            withHeaders:headers
           withCallback:cb];
}

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
         withCallback:(void (^)(RKMappingResult*, NSError*))cb
{
    [self requestToPath:path
             withMethod:method
            withMapping:mapping
             withParams:params
            withHeaders:headers
            withKeyPath:NULL
           withCallback:cb];
}

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
          withKeyPath:(NSString*)keyPath
         withCallback:(void (^)(RKMappingResult*, NSError*))cb
{
    [self requestToPath:path
             withMethod:method
            withMapping:mapping
             withParams:params
            withHeaders:headers
            withKeyPath:keyPath
               withBody:nil
           withCallback:cb];
}

- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
          withKeyPath:(NSString*)keyPath
             withBody:(id)body
         withCallback:(void (^)(RKMappingResult*, NSError*))cb
{
    void (^callback)(RKObjectRequestOperation*, RKMappingResult*, NSError*) =
    ^(RKObjectRequestOperation* op, RKMappingResult* result, NSError* err){
        cb(result, err);
    };
    
    [self requestToPath:path
             withMethod:method
            withMapping:mapping
             withParams:params
            withHeaders:headers
            withKeyPath:keyPath
               withBody:body
    withRestkitCallback:callback];
}


- (void)requestToPath:(NSString*)path
           withMethod:(RKRequestMethod)method
          withMapping:(RKMapping*)mapping
           withParams:(NSDictionary*)params
          withHeaders:(NSDictionary*)headers
          withKeyPath:(NSString*)keyPath
             withBody:(id)body
  withRestkitCallback:(RestKitCallback)cb
{
    NSIndexSet* statusCodeSet = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    NSMutableURLRequest *request = [self.manager requestWithObject:nil
                                                            method:method
                                                              path:path
                                                        parameters:params];
    
    //Add Headers to the request.
    if (headers) {
        for (NSString* key in [headers keyEnumerator]) {
            [request addValue:headers[key] forHTTPHeaderField:key];
        }
    }
    
    if (body) {
        NSError* error = nil;
        NSData *json = [RKMIMETypeSerialization dataFromObject:body MIMEType:RKMIMETypeJSON error:&error];
        
        if (!json && error) {
            cb(nil, nil, error);
        }
        
        [request setHTTPBody:json];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    NSArray* descriptors;
    
    if (mapping) {
        NSString* fullPath = request.URL.path;
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                                method:method
                                                                                           pathPattern:fullPath
                                                                                               keyPath:keyPath
                                                                                           statusCodes:statusCodeSet];
        
        descriptors = @[responseDescriptor];
    } else {
        descriptors = @[];
    }
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:descriptors];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation* op, RKMappingResult* mappingResult) {
        cb(op, mappingResult, nil);
    } failure:^(RKObjectRequestOperation *op, NSError *error) {
        cb(op, nil, error);
    }];
    
    [operation start];
}


@end
