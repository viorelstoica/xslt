import { Button, Col, Row, Container } from 'react-bootstrap/'
import { useState, useEffect } from 'react';
import { useNavigate } from "react-router";

import Loader from './Loader'
import './App.css'

function getDate() {
  const today = new Date();
  const month = today.getMonth() + 1;
  const year = today.getFullYear();
  const date = today.getDate();
  return `${month}/${date}/${year}`;
}

export default function Report3({ day }) {

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
          <Table3 day={day} />
        </Col>
        <Col></Col>
      </Row>
    </Container>
  )

}

function Table3({ day }) {
  const [sort, setSort] = useState(1)
  const [sortOrder, setSortOrder] = useState([1, 1, 1, 1])
  const [data, setData] = useState({})
  const [loading, setLoading] = useState(true)
  let navigate = useNavigate()

  console.log(`http://localhost:3000/output/errors/${day}`)

  const dataFetch = async () => {
    const response = await fetch(`http://localhost:3000/output/errors/${day}`)
    const json = await response.json()
    setData(json)
    setLoading(false)
  }

  useEffect(() => {
    dataFetch()
  }, [day]);


  function sortFunction(col) {
    switch (col) {
      case 1:
        data.sort((a, b) => {
          return sortOrder[col - 1] * (a.e < b.e ? -1 : a.e > b.e ? 1 : 0)
        })
        break;
      case 2:
        data.sort((a, b) => {
          return sortOrder[col - 1] * (a.cnt - b.cnt)
        })
        break;
    }
    sortOrder[col - 1] = -sortOrder[col - 1]
    setSort(sort + 1);
  }

  if (loading) {
    return (
      <div className="card mb-5">
        <div className="card-header">
          <h5 className="mb-0"><i className="fas fa-list me-2"></i>Errors per entity</h5>
        </div>
        <div className="card-body" style={{ width: '100%' }}>
          <Loader />
        </div>
      </div>
    )
  }
  else {
    console.log('data:', data)
    return (
      <div className="card mb-5">
        <div className="card-header">
          <h5 className="mb-0"><i className="fas fa-list me-2"></i>Errors per entity</h5>
        </div>
        <div className="card-body">
          <div className="table-responsive">
            <table className="table table-sm table-hover align-middle">
              <thead className="table-light sticky-top">
                <tr>
                  <th className="sortable" onClick={() => sortFunction(1)}>Error</th>
                  <th className="sortable" onClick={() => sortFunction(2)}>Count</th>
                </tr>
              </thead>
              <tbody>
                {data.map(l => (
                  <tr className="sortable table-light" onClick={() => navigate(`/report4/${day}/${l.e}`)}>
                    <td className="fw-bold text-secondary">{l.e}</td>
                    <td className="fw-bold text-secondary">{l.cnt}</td>
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