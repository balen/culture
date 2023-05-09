//import Axios from 'axios-observable';
import axios from 'axios';

// here
export const http = axios.create({})

http.interceptors.response.use(
  response => {
    if (response.status == 503) {
      window.location = "/maintenance.html"
    }
    return response;
  },
  error => {
    if (error.response.status == 503) {
      window.location = "/maintenance.html"
    }

    return Promise.reject(error)
  }
);

http.interceptors.request.use(
  config => {
    const method = config.method.toUpperCase()
    if (method !== 'OPTIONS' && method !== 'GET') {
      let token = $cookies.get('XSRF-TOKEN')
      config.headers = {
        ...config.headers,
        'X-CSRF-TOKEN': token
      }
    }
    return config
  }
);
