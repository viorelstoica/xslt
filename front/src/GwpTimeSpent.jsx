import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';

import { useLayoutEffect, useRef, useContext, useEffect, useState } from 'react';
import * as am5 from "@amcharts/amcharts5";
import * as am5xy from "@amcharts/amcharts5/xy";
import am5themes_Animated from "@amcharts/amcharts5/themes/Animated";
import { AppContext } from './Context.jsx';

export default function GwpTimeSpent({ date }) {

  console.log(`in gwptimespent component with date = ${date}`)
  const chartRef = useRef(null);
  const [data, setData] = useState([])

  const fetchData = async () => {
    console.log(`in gwptimespent before fetching with date = ${date}`)
    if (!!date) {
      console.log(`in gwptimespent component fetching with date = ${date}`)
      const response = await fetch(`http://localhost:3000/xmluuid/${date}`);
      const data = await response.json();
      setData(data)
    }
  }

  useEffect(() => {
    fetchData()
  }, [date])

  useLayoutEffect(() => {
    let root = am5.Root.new("GwpackTimeSpentDiv");
    drawChart(root)
    return () => {
      root.dispose();
    };
  }, [data]);
  
  function drawChart(root) {

    root.setThemes([am5themes_Animated.new(root)])
    const myTheme = am5.Theme.new(root)
    myTheme.rule("AxisLabel", ["minor"]).setAll({ dy: 1 })
    root.setThemes([am5themes_Animated.new(root)])
    var chart = root.container.children.push(am5xy.XYChart.new(root, { panX: false, panY: false, wheelX: "panX", wheelY: "zoomX", paddingLeft: 0 }));
    var cursor = chart.set("cursor", am5xy.XYCursor.new(root, { behavior: "zoomX" }));
    cursor.lineY.set("visible", false);

    var xAxis = chart.xAxes.push(am5xy.CategoryAxis.new(root, { categoryField: "date", renderer: am5xy.AxisRendererX.new(root, {}), tooltip: am5.Tooltip.new(root, { themeTags: ["axis"] }) }));
    var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, { renderer: am5xy.AxisRendererY.new(root, {}) }));

    var series = chart.series.push(am5xy.ColumnSeries.new(root, {
      name: "Series",
      xAxis: xAxis,
      yAxis: yAxis,
      valueYField: "value",
      categoryXField: "date",
      tooltip: am5.Tooltip.new(root, {
        labelText: "{valueY}"
      })
    }));

    series.columns.template.setAll({ strokeOpacity: 0 })

    chart.set("scrollbarX", am5.Scrollbar.new(root, {
      orientation: "horizontal"
    }));

    var chartData = []
    Object.keys(data).forEach(k => chartData.push({ date: k, value: data[k].avg }))
    xAxis.data.setAll(chartData);
    series.data.setAll(chartData)

    series.appear(1000);
    chart.appear(1000, 100);

    chartRef.current = chart;
  }

  return (
    <div>
      <p>
        Time spent in GWPACK on {date}
      </p>
      <div id="GwpackTimeSpentDiv"></div>
    </div>
  )
}