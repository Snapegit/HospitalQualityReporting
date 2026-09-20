const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 12587;
const STATIC_PREFIX = '/zrl-report';
const API_PREFIX = '/zrl-report-prod-api';
const BACKEND_HOST = '127.0.0.1';
const BACKEND_PORT = 13576;
const ROOT = __dirname;

const MIME = {
  '.html': 'text/html; charset=utf-8', '.js': 'application/javascript', '.css': 'text/css',
  '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.gif': 'image/gif',
  '.ico': 'image/x-icon', '.svg': 'image/svg+xml', '.json': 'application/json',
  '.woff': 'font/woff', '.woff2': 'font/woff2', '.ttf': 'font/ttf', '.eot': 'application/vnd.ms-fontobject'
};

http.createServer((req, res) => {
  const url = req.url || '/';

  // API: /zrl-report-prod-api/* -> backend 13576/*
  if (url.startsWith(API_PREFIX)) {
    const targetPath = url.slice(API_PREFIX.length) || '/';
    const preq = http.request({
      host: BACKEND_HOST, port: BACKEND_PORT, path: targetPath, method: req.method,
      headers: Object.assign({}, req.headers, { host: BACKEND_HOST + ':' + BACKEND_PORT })
    }, pres => { res.writeHead(pres.statusCode, pres.headers); pres.pipe(res); });
    preq.on('error', () => {
      res.writeHead(502, { 'Content-Type': 'application/json; charset=utf-8' });
      res.end('{"code":500,"msg":"backend not running (start the 13576 backend first)"}');
    });
    req.pipe(preq);
    return;
  }

  // Static: /zrl-report/* -> files in this folder
  if (url.startsWith(STATIC_PREFIX)) {
    let p = url.slice(STATIC_PREFIX.length).split('?')[0];
    if (p === '/' || p === '') p = '/index.html';
    const file = path.join(ROOT, decodeURIComponent(p));
    if (!file.startsWith(ROOT)) { res.writeHead(403); res.end('Forbidden'); return; }
    fs.readFile(file, (err, data) => {
      if (err) { res.writeHead(404); res.end('Not Found'); return; }
      res.writeHead(200, { 'Content-Type': MIME[path.extname(file).toLowerCase()] || 'application/octet-stream' });
      res.end(data);
    });
    return;
  }

  // Others -> redirect to dashboard
  res.writeHead(302, { Location: STATIC_PREFIX + '/index.html' });
  res.end();
}).listen(PORT, () => {
  console.log('zrl-report dashboard: http://localhost:' + PORT + '/zrl-report/index.html');
  console.log('NOTE: start the backend (port ' + BACKEND_PORT + ') first, or the dashboard will have no data.');
});
