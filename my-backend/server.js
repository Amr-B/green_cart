const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const groceries = require('./data/groceries');


const app = express();
app.use(cors());
app.use(bodyParser.json());

// GET All groceries
app.get('/groceries', (req, res) => {
    res.json(groceries);
});

// POST إضافة منتج جديد
app.post('/groceries', (req, res) => {
    const grocery = req.body;
    grocery.id = data.length + 1;
    groceries.push(grocery);
    res.status(201).json(grocery);
});

app.listen(3000, () => {
    console.log('🚀 Server running on http://localhost:3000');
});
