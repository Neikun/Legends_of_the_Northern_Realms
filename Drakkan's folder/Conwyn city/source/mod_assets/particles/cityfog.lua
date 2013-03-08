 defineParticleSystem{
       name = "cityfog",
       emitters = {     
       -- fog
          {
          emissionRate = 1.5,
          emissionTime = 0,
          maxParticles = 100,
          boxMin = {-6, 0.1, -3},
          boxMax = { 6, 0.1,  3},
          sprayAngle = {0,30},
          velocity = {0,0},
          texture = "assets/textures/particles/smoke_01.tga",
          lifetime = {10,20},
          color0 = {2.55, 2.55, 2.55},
          opacity = 0.2,
          fadeIn = 9,
          fadeOut = 9,
          size = {4, 6},
          gravity = {0,0,0},
          airResistance = 0.1,
          rotationSpeed = 0.05,
          blendMode = "Translucent",
          objectSpace = false,
          }
       }
    }
