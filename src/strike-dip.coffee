d3 = require 'd3'
# Class to create a strike-dip marker
module.exports = ->
  _strike = (d)->d.strike
  _dip = (d)->d.dip
  _color = 'black'
  _projection = null
  _sz = 10

  S = (d)->
    strike = _strike(d)
    if strike < 0
      strike += 360

    dip = _dip(d)


    i = d3.select @
      .attr class: "marker strike-dip"

    i.append "line"
        .attr
          x1: 0
          x2: _sz/2
          y1: 0
          y2: 0
          stroke: _color

    i.append "line"
      .attr
        x1: 0
        x2: 0
        y1: -_sz
        y2: _sz
        stroke: _color

    i.append "text"
      .text d3.round dip
      .attr
        class: "dip-magnitude"
        x: _sz
        y: 0
        "text-anchor": "middle"
        transform: "rotate(#{-strike} #{_sz} 0)"

    c = _projection(d)
    i.attr transform: "translate(#{c[0]} #{c[1]})
                        rotate(#{strike} 0 0)"

  getterSetter = (func)->
    (v)->
      return item unless v?
      func(v)
      return S

  S.color = getterSetter (d)->_color = d
  S.strike = getterSetter (d) -> _strike = d
  S.dip = getterSetter (d)->_dip = d
  S.projection = getterSetter (d)-> _projection = d
  S.scale = getterSetter (d)->_sz = d
  S
