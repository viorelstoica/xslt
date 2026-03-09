import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';

import { useLayoutEffect, useRef } from 'react';
import * as am5 from "@amcharts/amcharts5";
import * as am5xy from "@amcharts/amcharts5/xy";
import am5themes_Animated from "@amcharts/amcharts5/themes/Animated";

function Graph1() {

  var types = {"2025-08-27": { msgin : 100, msgout: 200}}
  const chartRef = useRef(null);

  var data = [];

  function drawChart(root) {
    root.setThemes([am5themes_Animated.new(root)]);

    var chart = root.container.children.push(am5xy.XYChart.new(root, { panX: false, panY: false, wheelX: "panX", wheelY: "zoomX", paddingLeft: 0, layout: root.verticalLayout }));
    var legend = chart.children.push(am5.Legend.new(root, { centerX: am5.p50, x: am5.p50 }))
    var yAxis = chart.yAxes.push(am5xy.CategoryAxis.new(root, {
      categoryField: "day",
      renderer: am5xy.AxisRendererY.new(root, {
        inversed: true,
        cellStartLocation: 0.1,
        cellEndLocation: 0.9,
        minorGridEnabled: true
      })
    }));

    yAxis.data.setAll(data);

    var xAxis = chart.xAxes.push(am5xy.ValueAxis.new(root, {
      renderer: am5xy.AxisRendererX.new(root, {
        strokeOpacity: 0.1,
        minGridDistance: 50
      }),
      min: 0
    }));

    function createSeries(field, name) {
      var series = chart.series.push(am5xy.ColumnSeries.new(root, {
        name: name,
        xAxis: xAxis,
        yAxis: yAxis,
        valueXField: field,
        categoryYField: "day",
        sequencedInterpolation: true,
        tooltip: am5.Tooltip.new(root, {
          pointerOrientation: "horizontal",
          labelText: "[bold]{name}[/]\n{categoryY}: {valueX}"
        })
      }));

      series.columns.template.setAll({
        height: am5.p100,
        strokeOpacity: 0
      });


      series.bullets.push(function () {
        return am5.Bullet.new(root, {
          locationX: 1,
          locationY: 0.5,
          sprite: am5.Label.new(root, {
            centerY: am5.p50,
            text: "{valueX}",
            populateText: true
          })
        });
      });

      series.bullets.push(function () {
        return am5.Bullet.new(root, {
          locationX: 1,
          locationY: 0.5,
          sprite: am5.Label.new(root, {
            centerX: am5.p100,
            centerY: am5.p50,
            text: "{name}",
            fill: am5.color(0xffffff),
            populateText: true
          })
        });
      });

      series.data.setAll(data);
      series.appear();

      return series;
    }

    createSeries("msgin", "msgin");
    createSeries("prefilter", "prefilter");
    createSeries("postfilter", "postfilter");
    createSeries("postmap", "postmap");
    createSeries("msgout", "msgout");

    var legend = chart.children.push(am5.Legend.new(root, {
      centerX: am5.p50,
      x: am5.p50
    }));

    legend.data.setAll(chart.series.values);


    var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {
      behavior: "zoomY"
    }));
    cursor.lineY.set("forceHidden", true);
    cursor.lineX.set("forceHidden", true);

    chartRef.current = chart;

  }
  useLayoutEffect(() => {
    let root = am5.Root.new("Graph1Div");
    drawChart(root)
    return () => {
      root.dispose();
    };
  }, []);

  useLayoutEffect(() => {
    data.length = 0
    Object.keys(types).map((day, i) => {
      var rec = {}
      rec['day'] = day
      Object.keys(types[day]).map((msg, j) => {
        rec[msg] = types[day][msg]
      })
      data.push(rec)
    })
    console.dir(data)
    chartRef.current.series.getIndex(0).data.setAll(data)
    chartRef.current.series.getIndex(1).data.setAll(data)
    chartRef.current.series.getIndex(2).data.setAll(data)
    chartRef.current.series.getIndex(3).data.setAll(data)
    chartRef.current.series.getIndex(4).data.setAll(data)
    chartRef.current.yAxes.getIndex(0).data.setAll(data);
  }, [data]);

  return (
    <div>
        <p>
          Messages per message type
        </p>
      <div id="Graph1Div"></div>
    </div>
  );
}





export default Graph1;



