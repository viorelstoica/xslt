import { Button, Col, Row, Container } from 'react-bootstrap/'
import { useState, useEffect } from 'react';
import { useNavigate, useParams } from "react-router";

import Loader from './Loader'
import './App.css'

function getDate() {
  const today = new Date();
  const month = today.getMonth() + 1;
  const year = today.getFullYear();
  const date = today.getDate();
  return `${month}/${date}/${year}`;
}

export default function Report4() {

  let { day, text }  = useParams()
  const [currentDate, setCurrentDate] = useState(getDate());
  return (

    <Container fluid>
      <Container className="p-5 mb-4 bg-light rounded-3">
        <h1 className="header">Output Processed errors</h1>
        <p>generated on {currentDate}</p>
      </Container>
      <Row className="my-2">
        <Col></Col>
        <Col xs={12}>
          <Table4 day={day} text={text}/>
        </Col>
        <Col></Col>
      </Row>
    </Container>
  )

}

function Table4({day, text}) {
  const [data, setData] = useState({})
  const [loading, setLoading] = useState(true)
  let navigate = useNavigate()

  
  const dataFetch = async () => {
    const response = await fetch(`http://localhost:3000/output/errors/${day}/${text}`)
    const json = await response.json()
    setData(json)
    setLoading(false)
  }

  useEffect(() => {
    dataFetch()
  }, [day]);


  if (loading) {
    return (
      <div className="card mb-5">
        <div className="card-header">
          <h5 className="mb-0"><i className="fas fa-list me-2"></i>Errors on {day}</h5>
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
          <h5 className="mb-0"><i className="fas fa-list me-2"></i>Errors on {day}</h5>
        </div>
        <div className="card-body">
          <div className="table-responsive">
            <table className="table table-sm table-hover align-middle">
              <thead className="table-light sticky-top">
                <tr>
                  <th>File</th>
                  <th>Line</th>
                  <th>Error</th>
                </tr>
              </thead>
              <tbody>
                {data.map(l => (
                  <tr className="sortable table-light" onClick={() => navigate(`/some/route?e=${l.id}`)}>
                    <td className="fw-bold text-secondary">{l.file}</td>
                    <td className="fw-bold text-secondary">{l.line}</td>
                    <td className="fw-bold text-secondary">{l.error}</td>
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