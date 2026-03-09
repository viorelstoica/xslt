import { Button, Col, Row, Container } from 'react-bootstrap/'
import { useState, useEffect } from 'react';
import Loader from './Loader'
import './App.css'

function getDate() {
  const today = new Date();
  const month = today.getMonth() + 1;
  const year = today.getFullYear();
  const date = today.getDate();
  return `${month}/${date}/${year}`;
}

export default function Report1() {

  const [currentDate, setCurrentDate] = useState(getDate());

  return (

    <Container fluid>
      <Container className="p-5 mb-4 bg-light rounded-3">
        <h1 className="header">Output Processed statistics</h1>
        <p>generated on {currentDate}</p>
      </Container>
      <Row className="my-2">
        <Col></Col>
        <Col xs={8}>
          <Table1 />
        </Col>
        <Col></Col>
      </Row>
    </Container>
  )

}



function Table1() {
  const [sort, setSort] = useState(1);
  const [sortOrder, setSortOrder] = useState([1,1,1,1])
  const [data, setData] = useState({});
  const [loading, setLoading] = useState(true);

  const dataFetch = async () => {
    const response = await fetch(`http://localhost:3000/output/stats`)
    const json = await response.json()
    setData(json)
    setLoading(false)
  }

  useEffect(() => {
    dataFetch()
  }, []);


  function sortFunction(col) {
    console.log('clicked on ', col, sortOrder[col-1])
    switch (col) {
      case 1:
        data.sort((a,b) => {
          return sortOrder[col-1]*(a.folder < b.folder ? -1 : a.folder > b.folder ? 1 : 0)
        })
        break;
      case 2:
        data.sort((a,b) => {
          return sortOrder[col-1]*(a.suc - b.suc)
        })
        break;
      case 3:
        data.sort((a,b) => {
          return sortOrder[col-1]*(a.err - b.err)
        })
        break;
      case 4:
        data.sort((a,b) => {
          return sortOrder[col-1]*(a.per - b.per)
        })
        break;
    }
    sortOrder[col-1] = -sortOrder[col-1]
    setSort(sort+1);
  }

  if (loading) {
    return (
      <div className="card mb-5">
        <div className="card-header">
          <h5 className="mb-0"><i className="fas fa-list me-2"></i>Errors per day</h5>
        </div>
        <div className="card-body" style={{ width: '100%' }}>
          <Loader />
        </div>
      </div>
    )
  }
  else {
    return (
      <div className="card mb-5">
        <div className="card-header">
          <h5 className="mb-0"><i className="fas fa-list me-2"></i>Errors per day</h5>
        </div>
        <div className="card-body">
          <div className="table-responsive">
            <table className="table table-sm table-hover align-middle">
              <thead className="table-light sticky-top">
                <tr>
                  <th className="sortable" onClick={() => sortFunction(1)}>Day</th>
                  <th className="sortable text-end" onClick={() => sortFunction(2)}>Success</th>
                  <th className="sortable text-end" onClick={() => sortFunction(3)}>Error</th>
                  <th className="sortable text-end" onClick={() => sortFunction(4)}>Rate</th>
                </tr>
              </thead>
              <tbody>
                {data.map(d => (
                  <tr className="table-light">
                    <td className="fw-bold text-secondary">{d.folder}</td>
                    <td className="text-end fw-bold">{d.suc}</td>
                    <td className="text-end fw-bold">{d.err}</td>
                    <td className="text-end text-success fw-bold">{d.per}%</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    )
  }
}

