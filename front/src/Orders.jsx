import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useContext, useState, useEffect, Suspense } from 'react'
import { AppContext } from './Context';
import { useLayoutEffect, useRef } from 'react';
import * as am5 from "@amcharts/amcharts5";
import * as am5xy from "@amcharts/amcharts5/xy";
import am5themes_Animated from "@amcharts/amcharts5/themes/Animated";


function Orders() {

  const [orders, setOrders] = useState([])

  const {
    services: {
      serviceApi
    }
  } = useContext(AppContext)

  useEffect(() => {
    serviceApi.getOrders().then(data => {
      setOrders(data)
    });
  }, []);


  return (
    <Suspense fallback={<Loading />}>
      <div id="chartdiv"></div>
    </Suspense>
  )
}

function Loading() {
  return <h2>🌀 Loading...</h2>;
}

export default Orders


