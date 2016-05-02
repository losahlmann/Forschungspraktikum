# plot piecewise continuous function
using Gadfly

f01(t) = (t-2)^2-5t^3
f12(t) = 5*(t-2)^2+t^3

## allowed
plot(
    layer(f01,0,1),
    layer(f12,1,2),
    Guide.annotation(compose(context(),
        circle(1.0, -4.0, 1.1mm),
        fill(nothing),
        stroke(colorant"black")
        )),
    Guide.annotation(compose(context(),
        circle(1.0, 6.0, 1mm),
        #fill(nothing),
        #stroke(colorant"orange")
        ))
    ))

## not allowed
plot(
    layer(f01,0,1),
    layer(f12,1,2),
    layer(x=[1],y=[3],Geom.point),
    Guide.annotation(compose(context(),
        circle(1.0, -4.0, 1.1mm),
        fill(nothing),
        stroke(colorant"black")
        )),
    Guide.annotation(compose(context(),
        circle(1.0, 6.0, 1.1mm),
        fill(nothing),
        stroke(colorant"black")
        ))
    )
