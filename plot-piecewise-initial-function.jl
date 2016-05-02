using Gadfly

plot(
    # initial function
    layer(t -> -1, -1, -1/2),
    Guide.annotation(compose(context(),
        circle(-1/2, -1, 1mm),
        fill(nothing),
        stroke(colorant"black")
        )),
    layer(t -> 1, -1/2, 0),
    Guide.annotation(compose(context(),
        circle(-1/2, 1, 1mm),
        #fill(nothing),
        #stroke(colorant"orange")
        )),
    Guide.annotation(compose(context(),
        circle(0, 1, 1mm),
        fill(nothing),
        stroke(colorant"black")
        )),
    Guide.annotation(compose(context(),
        circle(0, 1/2, 1mm),
        #fill(nothing),
        #stroke(colorant"orange")
        )),
    # solution
    layer(t -> 1/2+t, 0, 1/2),
    layer(t -> 3/2-t, 1/2, 1),
    layer(t -> -1/2*t^2+1/2*t+1/2, 1, 3/2),
    layer(t -> 1/2*t^2-5/2*t+11/4, 3/2, 2),
    layer(t -> 1/6*t^3-3/4*t^2+1/2*t+5/12, 2, 5/2),
    layer(t -> -1/6*t^3+7/4*t^2-23/4*t+45/8, 5/2, 3)
)
