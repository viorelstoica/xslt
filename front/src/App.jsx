import { useState } from 'react'
import { BrowserRouter, Routes, Route } from 'react-router'
import TheMenu from './TheMenu'
import TheFooter from './TheFooter'
import MainPage from './MainPage'
import Test from './Test'

import 'bootstrap/dist/css/bootstrap.min.css'
import './App.css'
import MsginHist from './MsginHist'
import MsginHistText from './MsginHistText'


function App() {

  const [fileName, setFileName] = useState("")
  const [date, setDate] = useState("")

  return (
    <>
      <TheMenu onFileName={setFileName} onDate={setDate}/>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<MainPage />} />
          <Route path="/msgin" element={<MsginHist date={'2026-02-23'} uuid={'f712aaa5-6317-4273-aabc-3e84263b2dee'}/>} />
          <Route path="/msgintext" element={<MsginHistText date={'2026-02-23'} uuid={'f712aaa5-6317-4273-aabc-3e84263b2dee'}/>} />
          <Route path="/test" element={<Test file={fileName}/>} />
        </Routes>
      </BrowserRouter>
      <TheFooter />
    </>
  )
}

export default App