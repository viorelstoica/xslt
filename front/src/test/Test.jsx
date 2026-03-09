import Container from 'react-bootstrap/Container';
import '../App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useContext, useState, useEffect, useLayoutEffect } from 'react'
import { AppContext } from '../Context';

function Test() {

  const [data, setData] = useState([])

  const {
    services: {
      serviceApi
    }
  } = useContext(AppContext)

  useEffect(() => {
    serviceApi.getOrders().then(data => {
      setData(data)
    });
  }, []);

  return (
    <div>
      <h3>Hello world</h3>
      <p>{JSON.stringify(data)}</p>
    </div>
  );
}

export default Test






