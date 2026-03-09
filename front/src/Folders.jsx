import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useContext, useState, useEffect, Suspense } from 'react'
import { AppContext } from './Context';
import { useLayoutEffect, useRef } from 'react';
import * as am5 from "@amcharts/amcharts5";
import * as am5xy from "@amcharts/amcharts5/xy";
import am5themes_Animated from "@amcharts/amcharts5/themes/Animated";


function Folders() {

  const [folders, setFolders] = useState([])

  const {
    services: {
      serviceApi
    }
  } = useContext(AppContext)

  useEffect(() => {
    serviceApi.getFolders().then(data => {
      setFolders(data)
    });
  }, []);

  useLayoutEffect(() => {
    let root = am5.Root.new("chartdiv");
    drawChart(root)
    return () => {
      root.dispose();
    };
  }, [folders]);


  function drawChart(root) {
    am5.ready(function () {
      root.setThemes([am5themes_Animated.new(root)]);
      //var chart = root.container.children.push(am5xy.XYChart.new(root, { panX: false, panY: false, wheelX: "none", wheelY: "none", paddingLeft: 0 }));
      var chart = root.container.children.push(am5xy.XYChart.new(root, { panX: true, panY: true, wheelX: "panX", wheelY: "zoomX", pinchZoomX: true, paddingLeft: 0 }));
      var yRenderer = am5xy.AxisRendererY.new(root, { minGridDistance: 30, minorGridEnabled: true });
      yRenderer.grid.template.set("location", 1);
      var yAxis = chart.yAxes.push(am5xy.CategoryAxis.new(root, { maxDeviation: 0, categoryField: "folder", renderer: yRenderer, tooltip: am5.Tooltip.new(root, { themeTags: ["axis"] }) }));
      var xAxis = chart.xAxes.push(am5xy.ValueAxis.new(root, { maxDeviation: 0, min: 0, numberFormatter: am5.NumberFormatter.new(root, { "numberFormat": "#,###a" }), extraMax: 0.1, renderer: am5xy.AxisRendererX.new(root, { strokeOpacity: 0.1, minGridDistance: 80 }) }));

      var series = chart.series.push(am5xy.ColumnSeries.new(root, {
        name: "Series 1",
        xAxis: xAxis,
        yAxis: yAxis,
        valueXField: "count",
        categoryYField: "folder",
        tooltip: am5.Tooltip.new(root, {
          pointerOrientation: "left",
          labelText: "{valueX}"
        })
      }));


      // Rounded corners for columns
      series.columns.template.setAll({
        cornerRadiusTR: 5,
        cornerRadiusBR: 5,
        strokeOpacity: 0
      });

      // Make each column to be of a different color
      series.columns.template.adapters.add("fill", function (fill, target) {
        return chart.get("colors").getIndex(series.columns.indexOf(target));
      });

      series.columns.template.adapters.add("stroke", function (stroke, target) {
        return chart.get("colors").getIndex(series.columns.indexOf(target));
      });

      var data = []
      Object.keys(folders).forEach(k => data.push({ folder: k, count: folders[k] }))
      yAxis.data.setAll(data);
      series.data.setAll(data);

      chart.set("cursor", am5xy.XYCursor.new(root, { behavior: "none", xAxis: xAxis, yAxis: yAxis }));
      var legend = chart.children.push(am5.Legend.new(root, { centerX: am5.p50, x: am5.p50 }))
      legend.data.setAll(chart.series.values);
      series.appear(1000);
      chart.appear(1000, 100);

    });
  }

  return (
    <Suspense fallback={<Loading />}>
      <div id="chartdiv"></div>
    </Suspense>
  )
}

function Loading() {
  return <h2>🌀 Loading...</h2>;
}

export default Folders


