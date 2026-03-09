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

  const keys = ["date", "time", "milli", "thread", "categ", "flow", "id"]  

  return (
    <div>
      <h3>Hello world</h3>
      <table>
        <thead>
          <tr>
            {keys.map((item, idx) => (
              <th key={idx}>{item}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {data.map((item, idx) => (
            <tr key={idx}>
              {keys.map((key, idx) => (
                <td>{item[key]}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default Test






