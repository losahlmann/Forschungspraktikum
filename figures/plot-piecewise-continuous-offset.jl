using Compose
using Gadfly

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
    # difference
    layer(θ->abs(f(3.49+θ)-f(3.5+θ)), -3.0, 0.0, Theme(default_color=colorant"red")),
    layer(θ->f(3.49+θ), -3.0, 0.0),
    layer(θ->f(3.5+θ), -3.0, 0.0, Theme(default_color=colorant"orange")),

    Theme(
        background_color = colorant"white",
        grid_color = colorant"#888888",
		panel_stroke = colorant"#888888",
        default_color = colorant"#1f77b4"),

    )

image = PNG("offset.png", 800px, 500px)

draw(image, p)
