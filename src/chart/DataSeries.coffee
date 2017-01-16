class DataSeries

    constructor: (options)->

        @data =
            type:         "scatter"
            legendText:   "New DataSeries"
            showInLegend: false
            dataPoints:   []
            pointCount:   0

        if options?
            $.extend @data, options

        @fieldName = 'label'

    ##|
    ##|  Set the color for this series
    setColor: (newColor)=>
        @data.color = newColor

    setLegend: (newText)=>
        @data.legendText = newText
        @data.showInLegend = true
        true

    ##|
    ##|  Sort the data points for time series data,
    ##|  not sure why we need to do this for some examples?
    sortTimeseries: ()=>
        @data.dataPoints = @data.dataPoints.sort (a,b)=>
            a1 = a.x || a.label
            b1 = b.x || b.label

            if !a1
                console.log "Invalid point:", a
                return -1

            if !b1
                console.log "Invalid point b:", b
                return 1

            if a1.getTime()<b1.getTime() then return -1
            return 1

    addRangePoint: (value, label)=>

        @data.type = "rangeColumn"

        @data.pointCount++
        for p in @data.dataPoints
            if p[@fieldName].toString() == label.toString()

                if !Array.isArray(p.y)
                    p.y = [ p.y ]
                p.y.push value
                p.y = p.y.sort()
                return true

        @data.type = "scatter"
        point =
            y: [value, value]

        point[@fieldName] = label
        @data.dataPoints.push(point)

    ##|
    ##| Some hard coded values based on the RR Dashboard for now
    setIndexLabelThousands: ()=>
        @data.indexLabel          = "{y}"
        @data.indexLabelFontColor = '#EBC641'
        @data.indexLabelFontSize  = 18
        @data.indexLabelFontStyle = 'bold'
        @data.indexLabelFormatter = (e)->
            return numeral(e.dataPoint.y).format("#,###") + " k"

        true

    ##|
    ##|  Add a new point and increase the value if the point already exists
    ##|  @see http://canvasjs.com/editor/?id=http://canvasjs.com/example/gallery/column/oil_reserves/
    addAggregatePoint: (value, label)=>

        for p in @data.dataPoints
            if p[@fieldName].toString() == label.toString()
                p.y = (p.y || 0) + value
                return true

        point =
            y: value

        point[@fieldName] = label
        @data.dataPoints.push(point)

    ##|
    ##|  Add a new point of data to the chart
    addPoint: (x, y, legendText)=>

        point = {}
        point.y = y
        point[@fieldName] = x
        if legendText
            point.legendText = legendText
        @data.dataPoints.push(point)
        return point

    ##|
    ##| Add a new point for bubble chart
    ##| @see http://canvasjs.com/editor/?id=http://canvasjs.com/example/gallery/bubble/emp_in_agriculture/
    addBubblePoint: (x, y, z, name) =>
        point = {
            x: x,
            y: y,
            z: z
        }
        point[@fieldName] = name
        @data.dataPoints.push(point)
        return point

    ##|
    ##|  See CanvasJS Series types:
    ##|  http://canvasjs.com/
    setSeriesType: (newType)=>
        @data.type = newType
        true

    getData: ()=>
        return @data

    getDataPoints: ()=>
        return @data.dataPoints