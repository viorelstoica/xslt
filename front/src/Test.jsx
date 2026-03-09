import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';

import { useLayoutEffect, useRef, useContext, useEffect, useState } from 'react';

export default function Test({date}) {

  const [data, setData] = useState([])

  const fetchData = async () => {

    if (!!date) {
      const response = await fetch(`http://localhost:3000/xmluuid/${date}`);
      const data = await response.json();
      setData(data)
    }
  }

  useEffect(() => {
    fetchData()
  }, [])

  return (
    <div>
      <p>
        Time spent in GWPACK on {date}
      </p>
      <div id="chartdiv"></div>
    </div>
  )
}