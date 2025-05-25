const app = require('./index');
require('dotenv').config();

const port=process.env.PORT || 3000;

app.listen(port, ()=>{
    console.log(`Servidor ativo em http://localhost:${port}`)
})