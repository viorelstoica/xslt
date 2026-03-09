import Container from 'react-bootstrap/Container';
import Card from 'react-bootstrap/Card';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useContext, useState, useEffect, useLayoutEffect } from 'react'
import { AppContext } from './Context';
import Table from 'react-bootstrap/Table';
import * as am5 from "@amcharts/amcharts5";
import * as am5xy from "@amcharts/amcharts5/xy";
import am5themes_Animated from "@amcharts/amcharts5/themes/Animated";

function TtiPerMin() {

  const [messages, setMessages] = useState([])

  const {
    services: {
      serviceApi
    }
  } = useContext(AppContext)

  useEffect(() => {
    serviceApi.getTtiBy5Min().then(data => {
      setMessages(data)
    });
  }, []);

  useLayoutEffect(() => {
    let root = am5.Root.new("chartdiv");
    drawChart(root)
    return () => {
      root.dispose();
    };
  }, [messages]);


  function drawChart(root) {
    am5.ready(function () {

      const myTheme = am5.Theme.new(root);

      root.setThemes([ am5themes_Animated.new(root), myTheme ]);

      var chart = root.container.children.push(am5xy.XYChart.new(root, {
        panX: false,
        panY: false,
        wheelX: "panX",
        wheelY: "zoomX",
        paddingLeft: 0
      }));

      var cursor = chart.set("cursor", am5xy.XYCursor.new(root, { behavior: "zoomX" }));
      cursor.lineY.set("visible", true);

      var xAxis = chart.xAxes.push(am5xy.CategoryAxis.new(root, { categoryField: "date", renderer: am5xy.AxisRendererX.new(root, {}), tooltip: am5.Tooltip.new(root, { themeTags: ["axis"] })}));
      var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, { renderer: am5xy.AxisRendererY.new(root, {}) }));

      var series = chart.series.push(am5xy.LineSeries.new(root, {
        name: "Series",
        xAxis: xAxis,
        yAxis: yAxis,
        valueYField: "value",
        categoryXField: "date",
        tooltip: am5.Tooltip.new(root, {
          labelText: "{valueX }"
        })
      }));

      // Actual bullet
      series.bullets.push(function () {
        var bulletCircle = am5.Circle.new(root, {
          radius: 3,
          fill: series.get("fill")
        });
        return am5.Bullet.new(root, {
          sprite: bulletCircle
        })
      })

      chart.set("scrollbarX", am5.Scrollbar.new(root, {
        orientation: "horizontal"
      }));

      var data = []
      Object.keys(messages).forEach(k => data.push({date: k, value:messages[k]}))
      xAxis.data.setAll(data)
      series.data.setAll(data);
      console.log(data)
      chart.set("cursor", am5xy.XYCursor.new(root, { behavior: "none", xAxis: xAxis, yAxis: yAxis }));

      series.appear(1000);
      chart.appear(1000, 100);

    });

  }

  return (<div id="chartdiv"></div>)
}


export default TtiPerMin






