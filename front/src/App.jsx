import { useState } from 'react'
import { BrowserRouter, Routes, Route } from 'react-router'
import TheMenu from './TheMenu'
import TheFooter from './TheFooter'
import MainPage from './MainPage';
import Test from './Test'

import 'bootstrap/dist/css/bootstrap.min.css';
import './App.css'

function App() {

  const [fileName, setFileName] = useState("")

  return (
    <>
      <TheMenu onFileName={setFileName}/>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<MainPage />} />
          <Route path="/test" element={<Test file={fileName}/>} />
        </Routes>
      </BrowserRouter>
      <TheFooter />
    </>
  )
}

export default App