import './App.css'
import 'bootstrap/dist/css/bootstrap.min.css'
import XMLViewer from 'react-xml-viewer'
import { useLayoutEffect, useRef, useContext, useEffect, useState } from 'react'

export default function Test({file}) {

  const [data, setData] = useState([])

  const fetchData = async () => {
    if (!!file) {
      const response = await fetch(`http://localhost:3000/file/${file.replaceAll("/", "%2F")}`);
      const data = await response.json();
      setData(data)
    }
  }

  useEffect(() => {
    fetchData()
  }, [file])

  return (
 <div>
      <XMLViewer xml={data} collapsible={true}   initialCollapsedDepth={3}/>
    </div>    
  )
}

/*
  return (
    <div>
      <p style={{whiteSpace: 'pre-wrap'}}>
        {data}
      </p>
    </div>
  )
*/