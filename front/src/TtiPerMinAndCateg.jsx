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

function TtiPerMinAndCateg() {

  const [messages, setMessages] = useState([])

  const {
    services: {
      serviceApi
    }
  } = useContext(AppContext)

  useEffect(() => {
    serviceApi.getTtiBy5MinAndCateg().then(data => {
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
      myTheme.rule("AxisLabel", ["minor"]).setAll({ dy: 1 });
      myTheme.rule("Grid", ["x"]).setAll({ strokeOpacity: 0.05 });
      myTheme.rule("Grid", ["x", "minor"]).setAll({ strokeOpacity: 0.05 });
      root.setThemes([ am5themes_Animated.new(root), myTheme ]);
      var chart = root.container.children.push(am5xy.XYChart.new(root, {
        panX: true,
        panY: true,
        wheelX: "panX",
        wheelY: "zoomX",
        maxTooltipDistance: 0,
        pinchZoomX: true
      }));

      var date = new Date();
      date.setHours(0, 0, 0, 0);
      var value = 100;

      function generateData() {
        value = Math.round((Math.random() * 10 - 4.2) + value);
        am5.time.add(date, "day", 1);
        return {
          date: date.getTime(),
          value: value
        };
      }

      function generateDatas(count) {
        var data = [];
        for (var i = 0; i < count; ++i) {
          data.push(generateData());
        }
        return data;
      }

      var xAxis = chart.xAxes.push(am5xy.DateAxis.new(root, {
        maxDeviation: 0.2,
        baseInterval: {
          timeUnit: "day",
          count: 1
        },
        renderer: am5xy.AxisRendererX.new(root, {
          minorGridEnabled: true
        }),
        tooltip: am5.Tooltip.new(root, {})
      }));

      var yAxis = chart.yAxes.push(am5xy.ValueAxis.new(root, {
        renderer: am5xy.AxisRendererY.new(root, {})
      }));

      for (var i = 0; i < 10; i++) {
        var series = chart.series.push(am5xy.LineSeries.new(root, {
          name: "Series " + i,
          xAxis: xAxis,
          yAxis: yAxis,
          valueYField: "value",
          valueXField: "date",
          legendValueText: "{valueY}",
          tooltip: am5.Tooltip.new(root, {
            pointerOrientation: "horizontal",
            labelText: "{valueY}"
          })
        }));

        date = new Date();
        date.setHours(0, 0, 0, 0);
        value = 0;

        var data = generateDatas(100);
        series.data.setAll(data);
        series.appear();
      }


      var cursor = chart.set("cursor", am5xy.XYCursor.new(root, { behavior: "none" })); cursor.lineY.set("visible", false);

      chart.set("scrollbarX", am5.Scrollbar.new(root, { orientation: "horizontal" }));
      chart.set("scrollbarY", am5.Scrollbar.new(root, { orientation: "vertical" }));

      var legend = chart.rightAxesContainer.children.push(am5.Legend.new(root, {
        width: 200,
        paddingLeft: 15,
        height: am5.percent(100)
      }));

      // When legend item container is hovered, dim all the series except the hovered one
      legend.itemContainers.template.events.on("pointerover", function (e) {
        var itemContainer = e.target;

        // As series list is data of a legend, dataContext is series
        var series = itemContainer.dataItem.dataContext;

        chart.series.each(function (chartSeries) {
          if (chartSeries != series) {
            chartSeries.strokes.template.setAll({
              strokeOpacity: 0.15,
              stroke: am5.color(0x000000)
            });
          } else {
            chartSeries.strokes.template.setAll({
              strokeWidth: 3
            });
          }
        })
      })

      // When legend item container is unhovered, make all series as they are
      legend.itemContainers.template.events.on("pointerout", function (e) {
        var itemContainer = e.target;
        var series = itemContainer.dataItem.dataContext;

        chart.series.each(function (chartSeries) {
          chartSeries.strokes.template.setAll({
            strokeOpacity: 1,
            strokeWidth: 1,
            stroke: chartSeries.get("fill")
          });
        });
      })

      legend.itemContainers.template.set("width", am5.p100);
      legend.valueLabels.template.setAll({
        width: am5.p100,
        textAlign: "right"
      });

      // It's is important to set legend data after all the events are set on template, otherwise events won't be copied
      legend.data.setAll(chart.series.values);

      chart.appear(1000, 100);

    });

  }

  return (<div id="chartdiv"></div>)
}


export default TtiPerMinAndCateg






