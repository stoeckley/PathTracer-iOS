//
//  Camera.swift
//  Raytracer
//
//  Created by Drew Ingebretsen on 1/1/15.
//  Copyright (c) 2015 Drew Ingebretsen. All rights reserved.
//

import Foundation

struct Camera {
    var cameraUp:Vector3D;
    var cameraRight:Vector3D;
    var cameraPosition:Vector3D;
    var aspectRatio:Float;

    init(cameraUp:Vector3D, cameraRight:Vector3D, cameraPosition:Vector3D, aspectRatio:Float){
        self.cameraUp = cameraUp;
        self.cameraRight = cameraRight;
        self.cameraPosition = cameraPosition;
        self.aspectRatio = aspectRatio;
    }
    
    func getRay(x:Float, y:Float) -> Ray{
        var camRight:Vector3D = cameraRight * aspectRatio;
        let lookAt:Vector3D = -cameraPosition.normalized();
        let base:Vector3D = camRight * x + cameraUp * y;
        let centered:Vector3D = base - Vector3D(x:camRight.x/2.0, y:cameraUp.y/2.0, z:(cameraUp + camRight).z/2.0);
        let direction = (centered + lookAt).normalized();
        return Ray(origin: cameraPosition, direction: direction);
    }
    
    
    
    func getParameterArray() -> [Vector3D]{
        return [cameraPosition, cameraUp, cameraRight];
    }
    
}