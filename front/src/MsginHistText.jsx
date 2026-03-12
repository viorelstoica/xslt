import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';

import { useLayoutEffect, useEffect, useState } from 'react';

function MsginHistText({ date, uuid }) {

  const [data, setData] = useState([]);

  const dataFetch = async () => {
    const response = await fetch(`http://localhost:3000/msgin/${date}/${uuid}`)
    const json = await response.json()
    setData(json)
  }

  useEffect(() => {
    dataFetch()
  }, []);

  return (
    <>
      <div className="table-responsive">
        <table className="table table-sm table-hover align-middle">
          <thead className="table-light sticky-top">
            <tr>
              <th>step</th>
              <th>flow</th>
              <th>time</th>
            </tr>
          </thead>
          <tbody>
            {data.map((e, idx) => (
              <tr className="sortable table-light">
                <td className="fw-bold text-secondary">{e.step}</td>
                <td className="fw-bold text-secondary">{e.flow}</td>
                <td className="fw-bold text-secondary">{e.time}.{e.milli}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  )
}


export default MsginHistText




