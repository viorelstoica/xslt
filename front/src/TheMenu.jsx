import { AppProvider, AppContext } from './Context'
import ContainerFluid from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import Form from 'react-bootstrap/Form';
import { useState, useEffect, useContext } from 'react';
import './App.css'

function TheMenu({ onFileName, onDate }) {

  const [dates, setDates] = useState([])

  const dataFetch = async () => {
    const response = await fetch(`http://localhost:3000/dates`)
    const json = await response.json()
    setDates(json)
  }

  useEffect(() => {
    dataFetch()
  }, []);

  return (
    <AppProvider>
      <Navbar expand="lg" className="navbar-expand-sm navbar-dark bg-secondary">
        <Form.Select className='my-form-select' onChange={(ev) => { console.log(ev.target.value); onDate(ev.target.value) }}>
          {dates.map(date => (
            <option key={date} value={date}>{date}</option>
          ))}
        </Form.Select>
        <Form.Select className='my-form-select' onChange={(ev) => { console.log(ev.target.value); onFileName(ev.target.value) }}>
          <option key={1} value={'version.txt'}>version.txt</option>
          <option key={2} value={'config/tti-flowmap.xml'}>tti-flowmap.xml</option>
          <option key={3} value={'xslt/AcAccrual/AcAccrual-Filter-Core.xsl'}>AcAccrual-Filter-Core.xsl</option>
        </Form.Select>
        <Nav className="justify-content-end">
          <Nav.Link href="/folders">Folders</Nav.Link>
          <NavDropdown title="tti" id="nav-dropdown">
            <NavDropdown.Item href="/msgin">msgin</NavDropdown.Item>
            <NavDropdown.Item href="/msgintext">msgintext</NavDropdown.Item>
          </NavDropdown>
          <Nav.Link href="/test">Test</Nav.Link>
        </Nav>

      </Navbar>
    </AppProvider>
  )
}

export default TheMenu