# plot piecewise continuous function
using Compose
using Gadfly

f01(t) = (t-2)^2-5t^3
f12(t) = 5*(t-2)^2+t^3

## allowed
p1 = plot(
    layer(f01, 0, 1),
    layer(f12, 1, 2),
    Guide.annotation(compose(context(),
        circle(1.0, -4.0, 1mm),
        fill(nothing),
        stroke(colorant"#1f77b4")
        )),
    Guide.annotation(compose(context(),
        circle(1.0, 6.0, 1mm),
        fill(colorant"#1f77b4"),
        )),
    Theme(
        background_color=colorant"white",
        default_color=colorant"#1f77b4")
		#grid_color=colorant"#888888",
		#panel_stroke=colorant"#888888"),
    )

## not allowed
p2 = plot(
    layer(f01, 0, 1),
    layer(f12, 1, 2),
    Guide.annotation(compose(context(),
        circle(1.0, 3.0, 1mm),
        fill(colorant"#1f77b4"),
        )),
    Guide.annotation(compose(context(),
        circle(1.0, -4.0, 1mm),
        fill(nothing),
        stroke(colorant"#1f77b4")
        )),
    Guide.annotation(compose(context(),
        circle(1.0, 6.0, 1.1mm),
        fill(nothing),
        stroke(colorant"#1f77b4")
        )),
    Theme(
        background_color=colorant"white",
        default_color=colorant"#1f77b4")
    )

image1 = PNG("allowed.png", 800px, 500px)
image2 = PNG("not-allowed.png", 800px, 500px)

draw(image1, p1)
draw(image2, p2)
