import { AppProvider, AppContext } from './Context'
import ContainerFluid from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import Form from 'react-bootstrap/Form';
import { useState, useEffect, useContext } from 'react';
import './App.css'

function TheMenu({onDate}) {

  const [dates, setDates] = useState([])
  const [cnt, setCnt] = useState(0)

  const {
    services: {
      serviceApi
    }
  } = useContext(AppContext)

  useEffect(() => {
    serviceApi.getDates().then(data => {
      setDates(data)
      onDate(data[0])
    });
  }, []);

  const loadFolderIndex = (value) => {
    serviceApi.loadFolderIndex(value).then(data => {
      setCnt(data.cnt)
    })
  }

  return (
    <AppProvider>

      <Navbar expand="lg" className="navbar-expand-sm navbar-dark bg-secondary">
        <Form.Select className='my-form-select' onChange={(ev) => { console.log(ev.target.value) ; onDate(ev.target.value) }}>
          {dates.map(date => (
            <option key={date} value={date}>{date}</option>
          ))}
        </Form.Select>
        <Nav className="justify-content-end">
          <Nav.Link href="/folders">Folders</Nav.Link>
          <NavDropdown title="GWPACK" id="nav-dropdown">
            <NavDropdown.Item href="/report1">Errors per day</NavDropdown.Item>
            <NavDropdown.Item href="/report2">Errors per entity</NavDropdown.Item>
            <NavDropdown.Item href="/report3">Error lines</NavDropdown.Item>
            <NavDropdown.Item href="/gwptimespent">Time spent in gwpack</NavDropdown.Item>
          </NavDropdown>
          <NavDropdown title="TTI" id="nav-dropdown">
            <NavDropdown.Item href="/ttipermin">ttipermin</NavDropdown.Item>
            <NavDropdown.Item href="/ttipermincateg">ttipermincateg</NavDropdown.Item>
            <NavDropdown.Item eventKey="4.3">delay</NavDropdown.Item>
          </NavDropdown>
          <Nav.Link href="/tti">Tti</Nav.Link>
          <Nav.Link href="/test">Test</Nav.Link>
        </Nav>

      </Navbar>
    </AppProvider>
  )
}

export default TheMenu