using Polynomials
using Gadfly


# calculate polynomial coefficients from boundary point values and derivatives
A = [1 0 0 0;
	 1 1 1 1;
	 0 1 0 0;
	 0 1 2 3]

# [g(t0),g(t1),(t1-t0)*g'(t0),(t1-t0)*g'(t1)] = [p(0),p(1),p'(0),p'(1)]
# on [-4,-3.25]
b0 = [1.3, 0.5, 1.7, -0.5]
# on [-3.25,-2]
b1 = [-0.2, 0.9, -1.125, 1.2]
# on [-2,-1.2]
b2 = [0.4, 0.8, -0.24, 2.0]
# on [-1.2,0]
b3 = [0.8, -0.8, 0.2, -0.48]

# coeff = [a,b,c,d]
c0 = A\b0
c1 = A\b1
c2 = A\b2
c3 = A\b3


# piecewise polynomial initial condition, scaled to ξ∈[0,1]
# p(ξ) = a + bξ + cξ^2 + dξ^3

# scale t∈[t0,t1] to ξ∈[0,1]
ξ(t,t0,t1) = (t-t0)/(t1-t0)

# initial condition on [t0,t1]
p0 = Poly(c0)
p1 = Poly(c1)
p2 = Poly(c2)
p3 = Poly(c3)
x0_0(t) = polyval(p0, ξ(t,-4.0,-3.25))
x0_1(t) = polyval(p1, ξ(t,-3.25,-2.0))
x0_2(t) = polyval(p2, ξ(t,-2.0,-1.2))
x0_3(t) = polyval(p3, ξ(t,-1.2, 0.0))
x0_4    = 1.5

# derivative of initial condition
Dp0 = polyder(p0)
Dp1 = polyder(p1)
Dp2 = polyder(p2)
Dp3 = polyder(p3)
Dx0_0(t) = polyval(Dp0, ξ(t,-4.0,-3.25))
Dx0_1(t) = polyval(Dp1, ξ(t,-3.25,-2.0))
Dx0_2(t) = polyval(Dp2, ξ(t,-2.0,-1.2))
Dx0_3(t) = polyval(Dp3, ξ(t,-1.2, 0.0))

# DDE x'(t)=-x(t-τ) on [0,4]
τ = 4.0
P0 = polyint(-p0)
P1 = polyint(-p1)
P2 = polyint(-p2)
P3 = polyint(-p3)

# solution of IVP: sol(t) = sol(a) + Pa(ξ(t-τ)) - Pa(ξ(a-τ))
# on [0,0.75]
x_0 = x0_4 + P0 - polyval(P0, ξ(-τ,-4.0,-3.25))
# on [0.75,2]
x_1 = polyval(x_0, ξ(0.75-τ,-4.0,-3.25)) + P1 - polyval(P1, ξ(0.75-τ,-3.25,-2.0))
# on [2,2.8]
x_2 = polyval(x_1, ξ(2.0-τ,-3.25,-2.0)) + P2 - polyval(P2, ξ(2.0-τ,-2.0,-1.2))
# on [2.8,4]
x_3 = polyval(x_2, ξ(2.8-τ,-2.0,-1.2)) + P3 - polyval(P3, ξ(2.8-τ,-1.2, 0.0))


function x(t)
	t = round(t, 8)
	if -4.0 <= t < -3.25
		x0_0(t)
	elseif -3.25 <= t < -2.0
		x0_1(t)
	elseif -2.0 <= t < -1.2
		x0_2(t)
	elseif -1.2 <= t < 0.0
		x0_3(t)
	elseif 0.0 <= t < 0.75
		polyval(x_0, ξ(t-τ,-4.0,-3.25))
	elseif 0.75 <= t < 2.0
		polyval(x_1, ξ(t-τ,-3.25,-2.0))
	elseif 2.0 <= t < 2.8
		polyval(x_2, ξ(t-τ,-2.0,-1.2))
	elseif 2.8 <= t <= 4.0
		polyval(x_3, ξ(t-τ,-1.2, 0.0))
	else
        throw(ArgumentError("Out of definition domain!"))
    end
end

function Dx(t)
	t = round(t, 8)
	if -4.0 <= t < -3.25
		Dx0_0(t)
	elseif -3.25 <= t < -2.0
		Dx0_1(t)
	elseif -2.0 <= t < -1.2
		Dx0_2(t)
	elseif -1.2 <= t < 0.0
		Dx0_3(t)
	elseif 0.0 <= t <= 4.0
		-x(t-τ)
	else
        throw(ArgumentError("Out of definition domain!"))
    end
end

# ζ-3.5 ∈ [-3.5,-3.25], ζ-2.0 ∈ [-2.0,-1.75]
# η_0 = x_0 + p0 + p2

# term along solution of DDE
η(ζ) = x(ζ) + x(ζ-3.5) + x(ζ-1.8)

# derivative of term along solution of DDE
Dη(ζ) = Dx(ζ) + Dx(ζ-3.5) + Dx(ζ-1.8)

p = plot(
	# initial condition on [-4,0]
	layer(x0_0, -4.0, -3.25),
	layer(x0_1, -3.25,-2.0),
	layer(x0_2, -2.0, -1.2),
	layer(x0_3, -1.2,  0.0),

	# derivative of initial condition on [-4,0]
	layer(Dx0_0, -4.0, -3.25, Theme(default_color=colorant"green")),
	layer(Dx0_1, -3.25,-2.0, Theme(default_color=colorant"green")),
	layer(Dx0_2, -2.0, -1.2, Theme(default_color=colorant"green")),
	layer(Dx0_3, -1.2,  0.0, Theme(default_color=colorant"green")),

	# solution of DDE
	layer(x, 0.0, 4.0),

	# term
	layer(η, 0.0, 4.0, Theme(default_color=colorant"red")),

	# layer(t->polyval(η_0, ξ(t-τ,0.0,0.25))+0.05, 0.0,0.25,Theme(default_color=colorant"yellow")),

	# derivative of term
	layer(Dη, 0.0, 4.0, Theme(default_color=colorant"green")),

	Theme(
        background_color=colorant"white",
        default_color=colorant"#1f77b4"
    ),

    Guide.xticks(
    	ticks=[-4.0,-3.25,-2.0,-1.2,0.0,
    		0.25,0.6,0.75,1.5,1.8,2.0,2.3,2.55,2.8,3.5,3.8,4.0])
)

image = PNG("differential-lemma.png", 2800px, 1000px)

draw(image, p)

println("initial condition p0: $p0")
println("initial condition p1: $p1")
println("initial condition p2: $p2")
println("initial condition p3: $p3")

println("deriv of init cond Dp0: $Dp0")
println("deriv of init cond Dp1: $Dp1")
println("deriv of init cond Dp2: $Dp2")
println("deriv of init cond Dp3: $Dp3")

println("sol of DDE x_0: $x_0")
println("sol of DDE x_1: $x_1")
println("sol of DDE x_2: $x_2")
println("sol of DDE x_3: $x_3")

function concat_coords(f,a,b)
	h = 0.01
	x = collect(a:h:b)
	s = ""
	for (x,y) in zip(x,round(map(f,x),4))
       s = s * "($x,$y) -- "
    end
    return s
end

# println("term value η_0: $(concat_coords(η,0.0,0.24))")
# println("term value η_1: $(concat_coords(η,0.25,0.6))")
# println("term value η_2: $(concat_coords(η,0.6,0.75))")
# println("term value η_3: $(concat_coords(η,0.75,1.49))")
# println("term value η_4: $(concat_coords(η,1.5,1.79))")
# println("term value η_5: $(concat_coords(η,1.8,2.0))")
# println("term value η_6: $(concat_coords(η,2.0,2.3))")
# println("term value η_7: $(concat_coords(η,2.3,2.55))")
# println("term value η_8: $(concat_coords(η,2.55,2.8))")
# println("term value η_9: $(concat_coords(η,2.8,3.49))")
# println("term value η_10: $(concat_coords(η,3.5,3.8))")
# println("term value η_11: $(concat_coords(η,3.8,4.0))")

println("term deriv Dη_0: $(concat_coords(Dη,0.0,0.24))")
println("term deriv Dη_1: $(concat_coords(Dη,0.25,0.59))")
println("term deriv Dη_2: $(concat_coords(Dη,0.6,0.74))")
println("term deriv Dη_3: $(concat_coords(Dη,0.75,1.49))")
println("term deriv Dη_4: $(concat_coords(Dη,1.5,1.79))")
println("term deriv Dη_5: $(concat_coords(Dη,1.8,1.99))")
println("term deriv Dη_6: $(concat_coords(Dη,2.0,2.29))")
println("term deriv Dη_7: $(concat_coords(Dη,2.3,2.54))")
println("term deriv Dη_8: $(concat_coords(Dη,2.55,2.8))")
println("term deriv Dη_9: $(concat_coords(Dη,2.8,3.49))")
println("term deriv Dη_10: $(concat_coords(Dη,3.5,3.79))")
println("term deriv Dη_11: $(concat_coords(Dη,3.8,3.99))")
