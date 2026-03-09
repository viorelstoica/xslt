import { createContext, useState } from 'react';
import ServiceApi from './ServiceApi';
const services = {
    serviceApi: new ServiceApi()
};
const AppContext = createContext();
const { Provider } = AppContext;
const AppProvider = ({ children }) => {
    return <Provider value={{ services }}>{children}</Provider>;
};
export { AppContext, AppProvider }