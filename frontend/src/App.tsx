import React, { useEffect, useState, FC } from 'react'
import { BrowserRouter, Link, Routes, Route } from 'react-router-dom';

const style = {display: 'flex', gap: '8px', padding: '8px'}
import './App.css'
import SearchBar from "./components/SearchBar"

const App: FC = () => {
   const [transactions, setTansaction] = useState({});
  /**
   * During development we can still access the base path at `/`
   * And this hook will make sure that we land on the base `/app`
   * path which will mount our App as usual.
   * In production, Phoenix makes sure that the `/app` route is
   * always mounted within the first request.
   * */
  useEffect(() => {
    if (window.location.pathname === '/') {
      window.location.replace('/app');
    }
  }, []);

    return (
        <div className="App">
            <SearchBar />
        </div>
    );
}

export default App
