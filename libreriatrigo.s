    .data

dieciseis: .float 16.0
pi: .float 3.1416
cinco: .float 5.0
cuatro: .float 4.0
pi2: .float 9.8696
piMedios: .float 1.57
trespiMedios: .float 4.71
dospi: .float 6.28
menosuno: .float -1.0

    .global libseno
    .global libcoseno
    .text

# -- FUNCIÓN SENO --

libseno:
    mov $0, %rbx                # -> %rbx como bandera

    ucomiss piMedios, %xmm0     # -> Cuadrante menor o igual a Pi/2
    jb seno
    
    ucomiss pi, %xmm0           # -> Cuadrante menor o igual a Pi
    jb cuadrante2

    ucomiss trespiMedios, %xmm0 # -> Cuadrante menor o igual a 3Pi/2
    jb cuadrante3
    
    ucomiss dospi, %xmm0        # -> Cuadrante menor o igual a 2Pi
    jb cuadrante4

cuadrante2:    
    movss pi, %xmm1
    subss %xmm0, %xmm1
    movss %xmm1, %xmm0

    jb seno
    
cuadrante3:
    movss pi, %xmm1
    subss %xmm1, %xmm0
    mov $1, %rbx

    jb seno

cuadrante4:
    movss dospi, %xmm1
    subss %xmm0, %xmm1
    movss %xmm1, %xmm0
    mov $1, %rbx

    jb seno

seno:
    movss %xmm0, %xmm1
    movss %xmm0, %xmm4
    movss %xmm0, %xmm5

    #Numerador 
    movss pi, %xmm2             # -> %xmm2 = 3.1416
    subss %xmm0, %xmm2          # -> %xmm2 = 3.1416 - x
    movss %xmm2, %xmm0          # -> %xmm0 = 2.1416
    
    mulss dieciseis, %xmm1      # -> %xmm1 = 16 * x
    mulss %xmm1, %xmm0          # -> %xmm0 = 16 * 2.1416

    #Denominador
    movss pi, %xmm3             # -> %xmm3 = 3.1416
    subss %xmm4, %xmm3          # -> %xmm3 = 3.1416 - x
    mulss cuatro, %xmm5         # -> %xmm5 = 4 * x
    mulss %xmm5, %xmm3          # -> %xmm3 = 4 * 2.14
    
    movss pi2, %xmm4            # -> %xmm4 = 9.8696
    mulss cinco, %xmm4          # -> %xmm4 = 5 * 9.8696
    
    subss %xmm3, %xmm4          # -> %xmm4 = 49.348 - 8.5664

    #División
    divss %xmm4, %xmm0          # -> %xmm0 = %xmm0 / %xmm4
    
    cmp $0, %rbx
    je finsen

cuadrante3y4:
    mulss menosuno, %xmm0       # -> Cuadrantes 3 y 4 se multiplicarán por -1 para su valor real


finsen:
    ret

# -- FUNCIÓN COSENO --

libcoseno:
    mov $0, %rbx                # -> %rbx como bandera

    ucomiss piMedios, %xmm0     # -> Cuadrante menor o igual a Pi/2
    jb coseno
    
    ucomiss pi, %xmm0           # -> Cuadrante menor o igual a Pi
    jb c2   

    ucomiss trespiMedios, %xmm0 # -> Cuadrante menor o igual a 3Pi/2
    jb c3
    
    ucomiss dospi, %xmm0        # -> Cuadrante menor o igual a 2Pi
    jb c4

c2:
    movss pi, %xmm1
    subss %xmm0, %xmm1
    movss %xmm1, %xmm0
    mov $1, %rbx
    
    jb coseno

c3:
    movss pi, %xmm1
    subss %xmm1, %xmm0
    mov $1, %rbx

    jb coseno

c4:
    movss dospi, %xmm1
    subss %xmm0, %xmm1
    movss %xmm1, %xmm0

    jb coseno

coseno:
    movss %xmm0, %xmm1
    movss %xmm0, %xmm3
    movss %xmm0, %xmm4

    #Numerador
    movss pi2, %xmm2            # -> %xmm2 = 9.8696
    mulss %xmm0, %xmm1          # -> %xmm1 = x*x
    mulss cuatro, %xmm1         # -> %xmm1 = 4x2
    subss %xmm1, %xmm2          # -> %xmm2 = pi2 - 4y2
    movss %xmm2, %xmm0

    #Denominador
    movss pi2, %xmm2            # -> %xmm2 = 9.8696
    mulss %xmm3, %xmm4          # -> %xmm4 = x*x
    addss %xmm4, %xmm2          # -> %xmm2 = pi2 + y2
    
    #División
    divss %xmm2, %xmm0

    cmp $0, %rbx
    je fincos

c3y4:
    mulss menosuno, %xmm0       # -> Cuadrantes 3 y 4 se multiplicarán por -1 para su valor real

fincos:
    ret
