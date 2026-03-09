import React, { useCallback } from 'react'
import { useContext, useEffect } from 'react';
import { useDropzone } from 'react-dropzone'
import { AppContext } from './Context';

function Drop2(props) {







  const {
    services: {
      logFile
    }
  } = useContext(AppContext)

  useEffect(() => {
    console.log(logFile.getCount())
  }, []);

  const onDrop = useCallback(async file => {

    const selectedFile = file[0]
    const chunkSize = 5 * 1024 * 1024; // 5MB (adjust based on your requirements)
    const totalChunks = Math.ceil(selectedFile.size / chunkSize);
    const chunkProgress = 100 / totalChunks;
    let chunkNumber = 0;
    let start = 0;
    let end = 0;

    const uploadNextChunk = async () => {
      if (end <= selectedFile.size) {
        const chunk = selectedFile.slice(start, end);
        const formData = new FormData();
        formData.append("file", chunk);
        formData.append("chunkNumber", chunkNumber);
        formData.append("totalChunks", totalChunks);
        formData.append("originalname", selectedFile.name);

        fetch("http://localhost:3000/upload", {
          method: "POST",
          body: formData,
        })
          .then((response) => response.json())
          .then((data) => {
            console.log({ data });
            const temp = `Chunk ${
              chunkNumber + 1
            }/${totalChunks} uploaded successfully`;
            console.log(temp);
            chunkNumber++;
            start = end;
            end = start + chunkSize;
            uploadNextChunk();
          })
          .catch((error) => {
            console.error("Error uploading chunk:", error);
          });
      } else {
      }
    };

    uploadNextChunk();



    /*
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
    */


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
export default Drop2