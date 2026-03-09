import './Drop.css';
import React, { useCallback } from 'react'
import { useContext, useEffect } from 'react';
import { useDropzone } from 'react-dropzone'
import { AppContext } from './Context';

function Drop(props) {

  const {
    services: {
      logFile
    }
  } = useContext(AppContext)

  useEffect(() => {
    console.log(logFile.getCount())
  }, []);

  const onDrop = useCallback(async file => {
    logFile.clear()
    const reader = new FileReader()
    reader.onload = function () {
      var cnt = 0, all =0
      const lines = reader.result.split('\n')
      lines.forEach(line => {
        all++
        if (line.startsWith('2025') && !line.match('F2B')) {
            logFile.addRecord(line)
          cnt++
        }
      })
      console.log(`${cnt} out of ${all} and ${logFile.getCount()}`)
      props.onData(cnt);
    }
    reader.readAsText(file[0])



  }, [])
  const { getRootProps, getInputProps, isDragActive } = useDropzone({ onDrop })

  return (
    <div className="Drop" {...getRootProps()}>
      <input {...getInputProps()} />
      {
        isDragActive ?
          <p>Drop the files here ...</p> :
          <p>Drag 'n' drop some files here, or click to select files</p>
      }
    </div>
  )
}
export default Drop;
