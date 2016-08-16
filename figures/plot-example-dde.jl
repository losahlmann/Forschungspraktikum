using Polynomials
using Gadfly

# DDE x'(t)=-x(t-τ) on [0,4]
τ = 1.0

# initial condition on [-1,0]
x0 = Poly([1])


# solution to DDE-IVP
# on [0,1]
x_1 = Poly([1,-1])
# on [1,2]
x_2 = Poly([3/2,-2,1/2])
# on [2,3]
x_3 = Poly([17/6,-4,3/2,-1/6])
# on [3,4]
x_4 = Poly([149/24,-17/2,15/4,-2/3,1/24])
# on [4,5]
x_5 = Poly([1769/120,-115/6,109/12,-2,5/24,-1/120])
# on [5,6]
x_6 = Poly([26239/720,-1085/24,1061/48,-197/36,35/48,-1/20,1/720])
# on [6,7]
x_7 = Poly([463609/5040,-13201/120,13081/240,-521/36,107/48,-1/5,7/720,-1/5040])


p = plot(
    layer(t->polyval(x_1, t), 0, 1),
    layer(t->polyval(x_2, t), 1, 2),
    layer(t->polyval(x_3, t), 2, 3),
    layer(t->polyval(x_4, t), 3, 4),
    layer(t->polyval(x_5, t), 4, 5),
    layer(t->polyval(x_6, t), 5, 6),
    layer(t->polyval(x_7, t), 6, 7),
    Theme(
        background_color=colorant"white",
        default_color=colorant"#1f77b4"
    )
)

image = PNG("example-dde.png", 800px, 500px)

draw(image, p)

function concat_coords(f,a,b)
    h = 0.01
    x = collect(a:h:b)
    s = ""
    for (x,y) in zip(x,round(map(f,x),4))
       s = s * "($x,$y) -- "
    end
    return s
end

println("x_1: ", concat_coords(t->polyval(x_1, t), 0, 1))
println("x_2: ", concat_coords(t->polyval(x_2, t), 1, 2))
println("x_3: ", concat_coords(t->polyval(x_3, t), 2, 3))
println("x_4: ", concat_coords(t->polyval(x_4, t), 3, 4))
println("x_5: ", concat_coords(t->polyval(x_5, t), 4, 5))
println("x_6: ", concat_coords(t->polyval(x_6, t), 5, 6))
println("x_7: ", concat_coords(t->polyval(x_7, t), 6, 7))