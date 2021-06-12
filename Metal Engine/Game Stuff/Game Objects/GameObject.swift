//
//  GameObject.swift
//  Metal Engine
//
//  Created by Anthony on 6/10/21.
//

import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    
    var mesh: Mesh!
    
    
    init(meshType: MeshTypes) {
        mesh = MeshLibrary.Mesh(meshType)
        
    }
    
    var time: Float = 0
    func update(deltaTime: Float) {
        time += deltaTime
        
        self.position.x = cos(time) / 2
        self.position.y = sin(time) / 2
        self.scale = simd_float3(repeating: 0.5)
        self.rotation.z = time
        
        updateModelConstants()
    }
    
    private func updateModelConstants() {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 1)
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibary.PipelineState(.Basic))
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}
