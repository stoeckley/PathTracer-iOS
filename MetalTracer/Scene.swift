//
//  Scene.swift
//  Raytracer
//
//  Created by Drew Ingebretsen on 12/13/14.
//  Copyright (c) 2014 Drew Ingebretsen. All rights reserved.
//

import Foundation

class Scene : NSObject {
    
    var camera:Camera;
    var light:Sphere;
    var spheres:[Sphere] = []
    var wallColors:[Vector3D] = []
    
    var context:MetalContext;
    
    var sphereBuffer:MTLBuffer!
    var cameraBuffer:MTLBuffer!
    var wallColorBuffer:MTLBuffer!
    
    var sphereData:[Sphere] = []
    var cameraData:[Vector3D] = []
    
    init(camera:Camera, light:Sphere, context:MetalContext){
        self.camera = camera;
        self.light = light;
        self.context = context;
    }
    
    func resetBuffer(){
        sphereData = [];
        sphereData.append(light);
        for sphere:Sphere in spheres{
            sphereData.append(sphere);
        }
        sphereBuffer = context.device.newBufferWithBytes(&sphereData, length: (sizeof(Sphere) + 3) * (spheres.count + 1), options:nil);
        
        cameraData = [camera.cameraPosition, camera.cameraUp];
        cameraBuffer = context.device.newBufferWithBytes(&cameraData, length: sizeof(Vector3D) * 2, options:nil);
        
        wallColorBuffer = context.device.newBufferWithBytes(&wallColors, length: sizeof(Vector3D) * 6, options:nil);
        
    }
    
    func getClosestHit(ray:Ray) -> Int{
        for i in (0...spheres.count-1){
            if (spheres[i].getBounds().intersectsWithRay(ray)){
                return i;
            }
        }
        return -1;
    }
    
    func addSphere(sphere:Sphere){
        spheres.append(sphere);
        resetBuffer();
    }
    
    func deleteSphere(index:Int){
        spheres.removeAtIndex(index);
        resetBuffer();
    }
}