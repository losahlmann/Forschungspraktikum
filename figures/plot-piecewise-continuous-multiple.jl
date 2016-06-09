using Compose
using Gadfly

l = (function()
        i = 0
        return l -> (
            if i < length(l)
                i+=1
                return l[i]
            else
                throw(ArgumentError("Label array too short!"))
            end
        )
    end)()

f_03_08(t) = (t-2)^2-5t^3
f_08_155(t) = 2*(t-0.55)
f_155_23(t) = 5*(t-2.5)^2+(t-0.5)^3-2
f_23_35(t) = -5*(t-3)^2+3#+(t-1)^3

function f(t)
    if 0.3<=t<0.8
        f_03_08(t)
    elseif 0.8<=t<1.55
        f_08_155(t)
    elseif 1.55<=t<2.3
        f_155_23(t)
    elseif 2.3<=t<=3.5
        f_23_35(t)
    else
        throw(ArgumentError("Out of definition domain!"))
    end
end

p = plot(
    layer(t->f(t)+2, 0.3, 3.5, Theme(default_color=colorant"orange")),
    Guide.annotation(compose(context(),
        circle(0.3, f_03_08(0.3), 1mm),
        fill(colorant"#1f77b4"),
        )),
    layer(f_03_08, 0.3, 0.8),
    Guide.annotation(compose(context(),
        circle(0.8, f_03_08(0.8), 1mm),
        fill(nothing),
        stroke(colorant"#1f77b4")
        )),

    Guide.annotation(compose(context(),
        circle(0.8, f_08_155(0.8), 1mm),
        fill(colorant"#1f77b4"),
        )),
    layer(f_08_155, 0.8, 1.55),
    Guide.annotation(compose(context(),
        circle(1.55, f_08_155(1.55), 1mm),
        fill(nothing),
        stroke(colorant"#1f77b4")
        )),

    Guide.annotation(compose(context(),
        circle(1.55, f_155_23(1.55), 1mm),
        fill(colorant"#1f77b4"),
        )),
    layer(f_155_23, 1.55, 2.3),
    Guide.annotation(compose(context(),
        circle(2.3, f_155_23(2.3), 1mm),
        fill(nothing),
        stroke(colorant"#1f77b4")
        )),

    Guide.annotation(compose(context(),
        circle(2.3, f_23_35(2.3), 1mm),
        fill(colorant"#1f77b4"),
        )),
    layer(f_23_35, 2.3, 3.5),
    Guide.annotation(compose(context(),
        circle(3.5, f_23_35(3.5), 1mm),
        fill(nothing),
        stroke(colorant"#1f77b4")
        )),

    Theme(
        background_color = colorant"white",
        grid_color = colorant"#888888",
		panel_stroke = colorant"#888888",
        default_color = colorant"#1f77b4"),
    Scale.x_continuous(
        labels = x -> l(["s","η1","η2","η3","t"])
        ),
    Guide.xticks(ticks = [0.5,0.8,1.55,2.3,3.0]),
    Guide.yticks(label = false, ticks = nothing),
	Guide.xlabel(nothing),
	Guide.ylabel("x")
    )

image = PNG("multiple.png", 800px, 500px)

draw(image, p)
